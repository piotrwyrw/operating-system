#define __SCREEN_CONSTANTS__
#include "screen.h"
#include "constants.h"
#include "memory.h"

void screen_init() {
	screen_current_buffer = 0;	// 0 is the back buffer at startup
	memset(screen_buffers[0], 0, __SCREEN_SIZE__);
	memset(screen_buffers[1], 0, __SCREEN_SIZE__);
}

void screen_swap() {
	memcpy(__VIDEO_ADDRESS__, __SCREEN_CURRENT_BUFFER__, __SCREEN_SIZE__);
	screen_current_buffer = (screen_current_buffer == 1) ? 0 : 1;
	memset(__SCREEN_CURRENT_BUFFER__, 0, __SCREEN_SIZE__);
}

int screen_xytoi(int x, int y) {
	return y * __SCREEN_WIDTH__ + x;
}

void screen_pixel(int x, int y, unsigned char c) {
    (__SCREEN_CURRENT_BUFFER__)[screen_xytoi(x, y)] = c;
}

void screen_rect(int x, int y, int w, int h, unsigned char c) {
	if (x < 0 || x + w > __SCREEN_WIDTH__ || y < 0 || y + h > __SCREEN_HEIGHT__) {
		return;     // Error
	}
	for (int _x = x; _x < x + w; _x ++) {
		for (int _y = y; _y < y + h; _y ++) {
			(__SCREEN_CURRENT_BUFFER__)[screen_xytoi(_x, _y)] = c;
		}
	}
}

void screen_clear(unsigned char c) {
    screen_rect(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__, c);
}

void screen_vga_pallete() {
	int px_w = __SCREEN_WIDTH__ / 16;
	int px_h = __SCREEN_HEIGHT__ / 16;
	unsigned char c = 0;
	for (int y = 0; y < 16; y ++) {
		for (int x = 0; x < 16; x ++) {
			screen_rect(x * px_w, y * px_h, px_w, px_h, c++);
		}
	}
}