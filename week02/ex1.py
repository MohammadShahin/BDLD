
# 3. What is the parameters that you can modify to increase the speed of PoW function?

# We can decrease difficulty_bits to get faster execution. Because when difficulty_bits is
# 256, we need the hash to be equal to exactly 0 (the only value which is less than the 
# target = 2 ** 0 = 1). When difficulty_bits is 0, target = 2 ** 256, all values which 
# result from the hashing function will be less than the target. Thus, a smaller value 
# for difficulty_bits means faster execution for a particular header.

# Decreaing max_nonce will only limit the method capability of finding the correct nonces.
# In contrast, increasing max_nonce will make improve it.

# Changing the header also affects the execution duration, but that change can't be 
# predicted (the principle of hashing funcitons).

# To make the execution even faster, we try to guess randomly rather than linearly. We 
# also can apply some kind multi-processing or threading for better perforamce.

import hashlib
import json
import time
from flask import Flask, request
from random import randint


max_nonce = 2 ** 32  # 4 billion
app = Flask(__name__)


def proof_of_work(header, difficulty_bits):

    target = 2 ** (256-difficulty_bits)
    for nonce in range(max_nonce):
        hash_result = hashlib.sha256((str(header) + str(nonce)).encode()).hexdigest()

        if int(hash_result, 16) < target:
            print("Success with nonce %d" % nonce)
            print("Hash is %s" % hash_result)
            return (hash_result, nonce)

    print("Failed after %d (max_nonce) tries" % nonce)
    return nonce



def proof_of_work_random(header, difficulty_bits):
    """
    This doesn't guarantee we went through all possible nounces, however it
    achieves better performances on average.
    """

    target = 2 ** (256-difficulty_bits)
    for _ in range(max_nonce):

        nonce = randint(0, max_nonce)

        hash_result = hashlib.sha256((str(header)+str(nonce)).encode()).hexdigest()

        if int(hash_result, 16) < target:
            print("Success with nonce %d" % nonce)
            print("Hash is %s" % hash_result)
            return (hash_result, nonce)

    print("Failed after %d (max_nonce) tries" % nonce)
    return nonce


@app.route("/")
def find_nonce():

    difficulty_bits = request.args.get('difficulty_bits', None)
    if not difficulty_bits:
        return 'Bad request: difficulty bits were not provided', 400

    difficulty_bits = int(difficulty_bits)
    nonce = 0
    hash_result = ''

    difficulty = 2 ** difficulty_bits

    print()
    print("Difficulty: %ld (%d bits)" % (difficulty, difficulty_bits))

    print("Starting search...")

    start_time = time.time()

    new_block = 'test block with transactions' + hash_result

    (hash_result, nonce) = proof_of_work(new_block, difficulty_bits)

    end_time = time.time()

    elapsed_time_simple = end_time - start_time

    print("Elapsed time: %.4f seconds" % elapsed_time_simple)

    if elapsed_time_simple > 0:

        hash_power_simple = float(int(nonce)/elapsed_time_simple)
        print("Hashing power: %ld hashes per second" % hash_power_simple)
    
    start_time = time.time()

    new_block = 'test block with transactions' + hash_result

    (hash_result_random, nonce_random) = proof_of_work_random(new_block, difficulty_bits)

    end_time = time.time()

    elapsed_time_random = end_time - start_time

    print("Elapsed time: %.4f seconds" % elapsed_time_random)

    if elapsed_time_random > 0:

        hash_power_random = float(int(nonce)/elapsed_time_random)
        print("Hashing power: %ld hashes per second" % hash_power_random)

    return json.dumps({
		'hash_result': hash_result,
		'nonce': nonce,
        'elapsed_time_simple_ms': elapsed_time_simple * 1000,

        'hash_result_random': hash_result_random,
        'nonce_random': nonce_random,
        'elapsed_time_random_ms': elapsed_time_random * 1000
	})


if __name__ == '__main__':
    app.run(port=3001, debug=True)
