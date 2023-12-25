#include "include/fractal.h"
#include "include/image.h"
#include <stdio.h>

int main() {
  image_p img = create_image(300, 300);

  fill_white(img);
  fractal(img, SIERPINSKI_CARPET);
  save_pgm(img, "sierpinski_carpet.pgm");

  fill_white(img);
  fractal(img, MANDELBROT_SET);
  save_pgm(img, "mandelbrot.pgm");

  free_image(img);
  return 0;
}
