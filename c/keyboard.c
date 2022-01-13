#include "keyboard.h"

#define __SCREEN_CONSTANTS__
#include "screen.h"

#include "colors.h"
#include "font.h"
#include "scancode.h"

void keyboard_handle(unsigned char scancode) {
    screen_rect(20, 20, __SCREEN_WIDTH__ - 40, __SCREEN_HEIGHT__ - 40, scancode);
    screen_swap();
}