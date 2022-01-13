#ifndef __SCREEN_WIDTH__
    #define __SCREEN_WIDTH__ 320
#endif
#ifndef __SCREEN_HEIGHT__
    #define __SCREEN_HEIGHT__ 200
#endif
#ifndef __SCREEN_SIZE__
    #define __SCREEN_SIZE__ (__SCREEN_WIDTH__ * __SCREEN_HEIGHT__)
#endif

#ifndef __SCREEN_H__
#define __SCREEN_H__

#define __SCREEN_CURRENT_BUFFER__ \
        screen_buffers[screen_current_buffer]

static unsigned char screen_buffers[2][__SCREEN_SIZE__];
static unsigned char screen_current_buffer; // The back buffer!!!

void screen_init();
void screen_swap();
int screen_xytoi(int x, int y);
void screen_pixel(int x, int y, unsigned char c);
void screen_rect(int x, int y, int w, int h, unsigned char c);
void screen_clear(unsigned char c);
void screen_vga_pallete();

#endif