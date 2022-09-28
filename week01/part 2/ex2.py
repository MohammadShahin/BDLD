
# a method to find the original text using rsa
from typing import Tuple, Union
from random import randint
from math import gcd

BASE = 512
E_LOWER_BOUND = 3


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


def text_to_number(text: str) -> int:
    number = 0
    power = 1
    for char in text:
        number = number + ord(char) * power
        power = power * BASE
    return number


def number_to_text(number: int) -> str:
    text_list = []
    while number:
        cur_char = chr(number % BASE)
        text_list.append(cur_char)
        number = number // BASE

    return ''.join(text_list)


def encrypt_rsa(text: Union[int, str], e: int, n: int) -> Tuple[int, str]:
    if isinstance(text, str):
        number = text_to_number(text)
    elif isinstance(text, int):
        number = text
    else:
        raise ValueError

    t = pow(number, e, n)
    return t


def decrypt_rsa(t: int, d: int, n: int) -> Tuple[int, str]:
    r = pow(t, d, n)
    return r, number_to_text(r)


if __name__ == '__main__':
    p, q = 845100400152152934331135470251, 56713727820156410577229101238628035243

    n, e, d = retrieve_params(p, q)

    text = "Encrypted message!"
    en_number = encrypt_rsa(text, e, n)
    de_number, de_text = decrypt_rsa(en_number, d, n)

    print(f"Original message: {text}")
    print(
        f"Encrypeted number: {en_number}, decrypeted number: {de_number}, decrypeted text: {de_text}")

    print("-" * 30)

    number = 12413479523490
    en_number = encrypt_rsa(number, e, n)
    de_number, _ = decrypt_rsa(en_number, d, n)

    print(f"Original number: {number}")
    print(f"Encrypeted number: {en_number}, decrypeted number: {de_number}")
