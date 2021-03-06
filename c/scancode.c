#include "scancode.h"

#define _(a, b) \
    case a:     \
        return b;

#define __(a, b, c) \
    case a:         \
        if (shift)  {   \
            return c;   \
        } else {        \
            return b;   \
        }               \

unsigned char char_from_scancode(unsigned char scancode, unsigned char shift) {
    switch (scancode) {
        __(0x04, '3', '#')
        __(0x08, '7', '&')
        __(0x0C, '-', '_')
        _(0x10, 'Q')
        _(0x14, 'T')
        _(0x18, 'O')
        _(0x20, 'D')
        _(0x24, 'J')
        __(0x28, '\'', '"')
        _(0x2C, 'Z')
        _(0x30, 'B')
        __(0x34, '.', '>')
        _(0x48, '8')
        _(0x4C, '5')
        _(0x50, '2')
        __(0x05, '4', '$')
        __(0x09, '8', '*')
        _(0x0D, '=')
        _(0x11, 'W')
        _(0x15, 'Y')
        _(0x19, 'P')
        _(0x21, 'F')
        _(0x25, 'K')
        _(0x29, '`')
        _(0x2D, 'X')
        _(0x31, 'N')
        __(0x35, '/', '?')
        __(0x49, '9', '(')
        __(0x4D, '6', '^')
        _(0x51, '3')
        _(0xE0, '/')
        __(0x02, '1', '!')
        __(0x06, '5', '%')
        __(0x0A, '9', '(')
        _(0x12, 'E')
        _(0x16, 'U')
        __(0x1A, '[', '{')
        _(0x1E, 'A')
        _(0x22, 'G')
        _(0x26, 'L')
        _(0x2E, 'C')
        _(0x32, 'M')
        _(0x4A, '-')
        _(0x4E, '+')
        _(0x52, '0')
        __(0x03, '2', '@')
        __(0x07, '6', '^')
        __(0x0B, '0', ')')
        _(0x13, 'R')
        _(0x17, 'I')
        __(0x1B, ']', '}')
        _(0x1F, 'S')
        _(0x23, 'H')
        __(0x27, ';', ':')
        _(0x2B, '\\')
        _(0x2F, 'V')
        __(0x33, ',', '<')
        _(0x37, '*')
        _(0x47, '7')
        _(0x4B, '4')
        _(0x4F, '1')
        _(0x53, '.')
        default:
            return 0;
    }
}

#undef _
#undef __