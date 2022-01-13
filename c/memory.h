#ifndef __MEMORY_H__
#define __MEMORY_H__

static unsigned int memory_allocated;
static unsigned char *memory_pointer;

void memory_init();
void *malloc(unsigned int size);
void memcpy(void *dst, void *src, unsigned int size);
void strcpy(void *dst, unsigned char *src);             // Memcpy for Strings
void memset(void *dst, unsigned char val, unsigned int size);

#endif