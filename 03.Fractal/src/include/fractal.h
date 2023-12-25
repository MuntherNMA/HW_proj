#ifndef FRACTAL_H
#define FRACTAL_H

#include "image.h"

typedef enum {
    SIERPINSKI_CARPET,
    MANDELBROT_SET,
} fractal_type;

void fractal(image_p picture, fractal_type type);

#endif // FRACTAL_H
