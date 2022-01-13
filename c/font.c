#include "font.h"
#include "string.h"
#include "screen.h"

void render_string(int x, int y, char *str, unsigned char c) {
    for (unsigned int i = 0; i < strlen(str); i ++) {
        render_letter(x + (i * 8 + 4), y, str[i], c);
    }
}

void render_letter(int _x, int _y, unsigned char _char, unsigned char c) {
    for (int x = 0; x < 8; x ++) {
        for (int y = 0; y < 8; y ++) {
            unsigned char px = font8x8[_char][y] & 1 << x;
            if (!px) continue;
            screen_pixel(x + _x, y + _y, c);
        }
    }
}