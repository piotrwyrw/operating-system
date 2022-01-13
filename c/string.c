#include "string.h"

unsigned int strlen(char *str) {
    char *ptr = str;
    unsigned int len = 0;
    while (*ptr) {
        ptr ++;
        len ++;
    }
    return len;
}