#include <ctime>
#include <iostream>
using namespace std;
int arr[1000][1000][1000];
int main(int argc, const char* argv[]) {
  clock_t startTime, endTime;
  startTime = clock();
  int sum = 0;
  for (int i = 0; i < 1000; i++)
    for (int j = 0; j < 1000; j++)
      for (int k = 0; k < 1000; k++) {
        arr[k][j][i] = i * j * k;
        sum += arr[k][j][i];
      }
  endTime = clock();
  cout << sum << endl;
  cout << (double)(endTime - startTime) / CLOCKS_PER_SEC << endl;
}