#!/usr/bin/env python3

import hashlib
import random
import string

to_collide = "000000"
grade = b"I accept my grade of 30 "

while to_collide != "e88792":
    m = hashlib.md5()
    for i in range(256):
        m.update(grade + random.choice(string.ascii_lowercase +
                                       string.ascii_uppercase + string.digits).encode())
        to_collide = m.hexdigest()[0:6]
        if to_collide != "e88792":
            break
    m.update(grade)
    to_collide = m.hexdigest()[0:6]
    print(grade)
    # print(to_collide)

print(grade)
