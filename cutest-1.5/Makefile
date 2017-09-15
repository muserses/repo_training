#
# Makefile
# muserses, 2017-09-15 23:04
#

.PHONY: all clean

#ARCH = arm
#CROSS_COMPILE = 
CC=arm-linux-gnueabihf-gcc-4.8.3
#CC=arm-none-eabi-gcc-4.8.3
CFLAGS=-Wall -g 

BIN=alltest

SRCS:=$(wildcard *.c)
OBJS:=$(patsubst %.c, %.o, $(SRCS))

INC=
LIBS=
DEFS=


all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) $(DEFS) -c $< -o $@

clean:
	rm -f *.o $(BIN)

# vim:ft=make
#
