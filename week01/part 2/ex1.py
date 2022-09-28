
from random import randint
from math import gcd
from typing import Tuple


E_LOWER_BOUND = 3

# egcd, modinv are taken from https://stackoverflow.com/questions/4798654/modular-multiplicative-inverse-function-in-python


def egcd(a, b):
    if a == 0:
        return (b, 0, 1)
    else:
        g, y, x = egcd(b % a, a)
        return (g, x - (b // a) * y, y)


def modinv(a, m):
    g, x, _ = egcd(a, m)
    if g != 1:
        raise Exception('modular inverse does not exist')
    else:
        return x % m


def retrieve_params(p: int, q: int) -> Tuple[int, int, int]:
    n = p * q
    r = (p - 1) * (q - 1)

    e = randint(E_LOWER_BOUND, n)

    while gcd(e, r) != 1:
        e = randint(E_LOWER_BOUND, n)

    d = modinv(e, r)

    return n, e, d


if __name__ == '__main__':
    n, e, d = retrieve_params(53, 59)
    print(
        f"Public key should be: (n = {n} and e = {e})\nPrivate key should be: (d = {d})")
