#!/usr/bin/env python3

from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from Crypto.Random import get_random_bytes
import string

key = get_random_bytes(16)

# encrypt the plaintext and return the ciphertext


def encrypt(plain):
    key = b'0123456789abcedf'
    cipher = AES.new(key, AES.MODE_ECB)
    padded_pt = pad(plain+b'AES-ECB-leaking!', 16)
    return cipher.encrypt(padded_pt).hex()


# decrypt the ciphertext and return the plaintext


def decrypt(ciphertext):
    cipher = AES.new(key, AES.MODE_ECB)
    return cipher.decrypt(ciphertext)


# print(encrypt(b"A"*15)[:17], encrypt(b"A"*16)[:17])

found = b""
while len(found) != 16:
    current_block = len(found) // 16 + 1

    guess = encrypt(
        b"A"*(16 * current_block - len(found) - 1)
    )[16 * (current_block - 1):(16 * current_block + 1)]
    for c in string.printable:
        print(b"A" * (16 * current_block - len(found) - 1) + found + c.encode())
        if guess == encrypt(
                b"A" * (16 * current_block - len(found) - 1) +
                found +
                c.encode()
        )[(16 * (current_block - 1)):(16 * current_block + 1)]:
            found += c.encode()
            break

    print(found)


# this can be useful to bruteforce, it contains all printable characters
# print(string.printable)
#
# # This is the function that simulates an oracle. You need to used this to find the secret message
# print(encrypt(b'testmessage'))
# print(encrypt(b''))  # this will return the encrypted secret message
