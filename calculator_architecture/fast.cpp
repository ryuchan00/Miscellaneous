#include <ctime>
#include <iostream>

using namespace std;

int main(int argc, const char *argv[]) {
  clock_t startTime, endTime;
  startTime = clock();
  const int w = 10000;
  const int h = 10000;
  int *src = new int[w * h];
  int *dst = new int[w * h];

  for (int v = 0; v < h; v++) {
    for (int u = 0; u < w; u++) {
      const int p = v * w + u;

      src[p] = 0;
      dst[p] = 0;
    }
  }

  for (int v = 0; v < h; v++) {
    for (int u = 0; u < w; u++) {
      const int p = v * w + u;

      const int a = src[p];
      dst[p] = a * a / 2;
    }
  }
  endTime = clock();
  cout << (double)(endTime - startTime) / CLOCKS_PER_SEC << endl;
}