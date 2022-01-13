#include "memory.h"
#include "string.h"

void memory_init() {
    // Tell where the "Heap" starts (1 GB after kernel start in this case)
    memory_pointer = ((unsigned char * ) (0x1000 + 1000000000));
}

// A very "memory-saving" way to implement malloc
void *malloc(unsigned int size) {
    unsigned char *ptr = memory_pointer;
    memory_pointer += size;
    memory_allocated += size;
    return ptr;
}

void memcpy(void *dst, void *src, unsigned int size) {
    unsigned char *_dst = (unsigned char *) dst;
    unsigned char *_src = (unsigned char *) src;
    for (unsigned int i = 0; i < size; i ++) {
        *(_dst + i) = *(_src + i);
    }
}

void strcpy(void *dst, unsigned char *src) {
    unsigned char *_dst = (unsigned char *) dst;
    memcpy(dst, src, strlen(src));
    *(_dst + strlen(src)) = '\0';
}

void memset(void *dst, unsigned char val, unsigned int size) {
    unsigned char *_dst = (unsigned char *) dst;
    for (unsigned int i = 0; i < size; i ++) {
        *(_dst + i) = val;
    }
}