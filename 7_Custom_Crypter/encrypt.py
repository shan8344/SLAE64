#!/usr/bin/python
#
# Author - shankar
# Python Cryptor with AES 128 & Base64

from Crypto.Cipher import AES
import sys
import base64

def encrypt(shell2base):
 block_size = 16 #Requires 16 bit key
 seperation ='{'
 pad = lambda s: s + (block_size - len(s) % block_size) * seperation
 encode = lambda c, s: base64.b64encode(c.encrypt(pad(s)))
 cipher = AES.new('1111222233334444') # key value 1111222233334444
 encoded = encode (cipher, shell2base)

 print 'AES Base64 Encrypted Shellcode: \r\n', encoded
 sys.exit(0)

inpcode = sys.argv[1]
crypted = encrypt(inpcode)
