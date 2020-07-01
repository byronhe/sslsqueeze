VERSION=1.0
# sudo apt install pkg-config libevent-dev
# make
CFLAGS=-O2 -Wall -g  
LDFLAGS=$(shell pkg-config --cflags --libs libevent libevent_core libevent_extra libevent_openssl libevent_pthreads)

sslsqueeze: sslsqueeze.o
	cc $? $(LDFLAGS) -o $@

sslsqueeze.exe: Makefile sslsqueeze.c
	i586-mingw32msvc-gcc -s -O2 -Wall -o sslsqueeze.exe sslsqueeze.c -levent_core -lws2_32

clean:
	rm -f sslsqueeze sslsqueeze.o

dist: dist-unix dist-win32

dist-unix:
	mkdir sslsqueeze-$(VERSION)
	ln Makefile sslsqueeze.c COPYRIGHT sslsqueeze-$(VERSION)
	tar -czf ../sslsqueeze-$(VERSION).tar.gz sslsqueeze-$(VERSION)
	rm -rf sslsqueeze-$(VERSION)

dist-win32: sslsqueeze.exe
	zip ../sslsqueeze-$(VERSION).zip sslsqueeze.exe

