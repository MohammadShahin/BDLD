# Mohammad Shahin B19-DS-01

import psycopg2

HOST = 'localhost'
USER = 'mohammadshahin'
DB_NAME = 'blockchain'
PASSWORD = 'psql'

ACCOUNTS_NAMES = ["account1", "account2", "account3"]
ACCOUNTS_BANKS = ["SpearBank", "Tinkoff", "SpearBank"]
TRANSACTIONS = [
    {
        "sender": 1,
        "reciever": 3,
        "amount": 500
    },
    {
        "sender": 2,
        "reciever": 1,
        "amount": 700
    },
    {
        "sender": 2,
        "reciever": 3,
        "amount": 100
    }
]

EXTERNAL_TRANSACTION_FEE = 30
INTERNAL_TRANSACTION_FEE = 0

CREATE_TABLE_ACCOUNTS_WITHOUT_BANK_QUERY = """
CREATE TABLE IF NOT EXISTS accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR (32) NOT NULL,
    credit INT NOT NULL CHECK (credit >= 0)
);
"""

CREATE_TABLE_ACCOUNTS_WITH_BANK_QUERY = """
CREATE TABLE IF NOT EXISTS accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR (32) NOT NULL,
    credit INT NOT NULL,
    bank_name VARCHAR (32) NOT NULL
);
"""

CREATE_TABLE_LEDGER_QUERY = """
CREATE TABLE IF NOT EXISTS ledger (
    id SERIAL PRIMARY KEY,
    from_account INT NOT NULL,
    to_account INT NOT NULL,
    fee INT NOT NULL CHECK (fee >= 0),
    amount INT NOT NULL CHECK (amount > 0), 
    transaction_datetime TIMESTAMP NOT NULL, 
    CONSTRAINT sender_validity
      FOREIGN KEY(from_account) 
	    REFERENCES accounts(id),
    CONSTRAINT reciever_validity
      FOREIGN KEY(to_account) 
	  REFERENCES accounts(id)
);
"""

INSERT_THREE_ACCOUNT_WITHOUT_BANK_QUERY = f"""
INSERT INTO 
accounts (name, credit) 
VALUES 
    ('{ACCOUNTS_NAMES[0]}', 1000),
    ('{ACCOUNTS_NAMES[1]}', 1000),
    ('{ACCOUNTS_NAMES[2]}', 1000);
"""

INSERT_THREE_ACCOUNT_WITH_BANK_QUERY = f"""
INSERT INTO 
accounts (name, credit, bank_name) 
VALUES 
    ('{ACCOUNTS_NAMES[0]}', 1000, '{ACCOUNTS_BANKS[0]}'),
    ('{ACCOUNTS_NAMES[1]}', 1000, '{ACCOUNTS_BANKS[1]}'),
    ('{ACCOUNTS_NAMES[2]}', 1000, '{ACCOUNTS_BANKS[2]}');
"""

GET_ACCOUNT_WITH_ID_QUERY = """
SELECT * FROM accounts
WHERE id = %s;
"""

DROP_TABLE_ACCOUNTS = """
DROP TABLE IF EXISTS accounts;
"""

SELECT_ALL_ACCOUNTS_TABLE = """
SELECT * FROM accounts;
"""

DROP_TABLE_LEDGER = """
DROP TABLE IF EXISTS ledger;
"""

SELECT_ALL_LEDGER_TABLE = """
SELECT * FROM ledger;
"""

UPDATE_ACCOUNTS_TABLE_TRANSACTION_SENDER = """
UPDATE accounts
SET credit = credit - %s 
WHERE id = %s
"""

UPDATE_ACCOUNTS_TABLE_TRANSACTION_RECEIVER = """
UPDATE accounts
SET credit = credit + %s 
WHERE id = %s
"""

INSERT_TO_LEDGER_QUERY = """
INSERT INTO
ledger (from_account, to_account, fee, amount, transaction_datetime)
VALUES (%s, %s, %s, %s, NOW())
"""

def get_connection():
    conn = psycopg2.connect(host=HOST, dbname=DB_NAME,
                            user=USER, password=PASSWORD)
    crsr = conn.cursor()
    return conn, crsr


def get_accounts_table():
    crsr.execute(SELECT_ALL_ACCOUNTS_TABLE)
    table = crsr.fetchall()
    return table


def get_ledger_table():
    crsr.execute(SELECT_ALL_LEDGER_TABLE)
    table = crsr.fetchall()
    return table


def exec_query(query: str):
    crsr.execute(query)
    conn.commit()


def add_transaction(sender_id: str, receiver_id: str, amount: int, with_bank_name: bool, with_ledger: bool):
    crsr.execute(GET_ACCOUNT_WITH_ID_QUERY, (sender_id, ))
    sender_info = crsr.fetchall()[0]

    crsr.execute(GET_ACCOUNT_WITH_ID_QUERY, (receiver_id, ))
    receive_info = crsr.fetchall()[0]

    fee = 0

    if with_bank_name:
        sender_bank = sender_info[-1]
        receiver_bank = receive_info[-1]

        if sender_bank != receiver_bank:
            fee = EXTERNAL_TRANSACTION_FEE
        else:
            fee = INTERNAL_TRANSACTION_FEE

    crsr.execute(UPDATE_ACCOUNTS_TABLE_TRANSACTION_SENDER,
                 (amount + fee, sender_id))
    crsr.execute(UPDATE_ACCOUNTS_TABLE_TRANSACTION_RECEIVER,
                 (amount, receiver_id))

    if with_ledger:
        crsr.execute(INSERT_TO_LEDGER_QUERY, (sender_id, receiver_id, fee, amount))

    conn.commit()


def handle_all(with_bank_name: bool = False, with_ledger: bool = False):
    global conn, crsr

    print(f"With{'' if with_bank_name else 'out'} Bank Name")
    print(f"With{'' if with_ledger else 'out'} ledger")
    print()

    if conn == None or crsr == None:
        conn, crsr = get_connection()

    # Droping existing tables.
    exec_query(DROP_TABLE_LEDGER)
    exec_query(DROP_TABLE_ACCOUNTS)

    # Creating the new tables according to the given parameters.
    if with_bank_name:
        exec_query(CREATE_TABLE_ACCOUNTS_WITH_BANK_QUERY)
        exec_query(INSERT_THREE_ACCOUNT_WITH_BANK_QUERY)
    else:
        exec_query(CREATE_TABLE_ACCOUNTS_WITHOUT_BANK_QUERY)
        exec_query(INSERT_THREE_ACCOUNT_WITHOUT_BANK_QUERY)

    if with_ledger:
        exec_query(CREATE_TABLE_LEDGER_QUERY)

    # Adding the transactions.
    [add_transaction(TRANSACTIONS[i]['sender'], TRANSACTIONS[i]['reciever'], TRANSACTIONS[i]['amount'], with_bank_name, with_ledger)
     for i in range(len(TRANSACTIONS))]

    accounts = get_accounts_table()
    print("Accounts:")
    for account in accounts:
        print(account)
    print()
    if with_ledger:
        ledger = get_ledger_table()
        print("Ledger:")
        for tx in ledger:
            print(tx)
        print()
    print("The credits are:")
    for account in accounts:
        print(account[1], account[2])

    print("-" * 30)


if __name__ == '__main__':
    conn, crsr = get_connection()

    # section 1
    handle_all(with_bank_name=False, with_ledger=False)

    # section 2
    handle_all(with_bank_name=True, with_ledger=False)

    # section 3
    handle_all(with_bank_name=False, with_ledger=True)

    # section 4
    handle_all(with_bank_name=True, with_ledger=True)
