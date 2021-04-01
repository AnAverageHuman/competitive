// written by Mathew Soto

#include <iostream>

float firstTri(float bx, float cx, float cy) { return bx * cy / 2.; }

// formula for reflection of a point across a line
// point: (p,q)
// line: ax+by+c=0
void reflection(float p, float q, float a, float b, float c, float *coords) {
  float x = (p * (a * a - b * b) - 2 * b * (a * q + c)) / (a * a + b * b);
  float y = (q * (b * b - a * a) - 2 * a * (b * p + c)) / (a * a + b * b);
  coords[0] = x;
  coords[1] = y;
}

// formula for area of a triangle given its coordinates
float area(float ax, float ay, float bx, float by, float cx, float cy) {
  float result = (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by)) / 2;
  if (result < 0) {
    return result * (-1);
  } else {
    return result;
  }
}

void secondTri(float bx, float cx, float cy) {
  float ax2 = cx;
  float ay2 = (cy * cy - cx * cx) / (2 * cy);
  float bx2 = bx / 2;
  float by2 = bx * (bx - cx) / (2 * cy);
  float cx2 = (bx * bx + 2 * bx * cx - cx * cx - cy * cy) / (2 * bx);
  float cy2 = cx * ((bx - cx) * (bx - cx) + cy * cy) / (2 * bx * cy);

  std::cout << area(ax2, ay2, bx2, by2, cx2, cy2) << " ";

  float coordsA[2];
  reflection(ax2, ay2, cx, -1 * cy, 0, coordsA);
  float ax3 = coordsA[0];
  float ay3 = coordsA[1];

  float bx3 = bx2;
  float by3 = -1 * by2;

  float coordsC[2];
  reflection(cx2, cy2, cx - bx, -1 * cy, cy * bx, coordsC);
  float cx3 = coordsC[0];
  float cy3 = coordsC[1];
  std::cout << area(ax3, ay3, bx3, by3, cx3, cy3) << std::endl;
}

int main() {
  float bx, cx, cy;
  std::cin >> bx;
  std::cin >> cx;
  std::cin >> cy;
  std::cout << firstTri(bx, cx, cy) << " ";
  secondTri(bx, cx, cy);
}
