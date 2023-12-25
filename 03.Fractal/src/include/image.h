#ifndef IMAGE_H
#define IMAGE_H

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

typedef uint8_t pixel_data;
typedef unsigned int pixel_coord;

typedef struct image {
    pixel_coord width;
    pixel_coord height;
    pixel_data *data;
} image_t;

typedef struct image *image_p;

image_p create_image(pixel_coord width, pixel_coord height);

void fill_random(image_p picture);

void fill_white(image_p picture);

void free_image(image_p picture);

void save_pgm(image_p picture, const char *filename);

void set_pixel(image_p picture, pixel_coord x, pixel_coord y, pixel_data color);

#endif // IMAGE_H
