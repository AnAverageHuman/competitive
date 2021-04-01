#include <array>
#include <iostream>

int main() {
  int P, K;
  std::cin >> P;
  unsigned long long Y;

  for (int i = 0; i < P; i++) {
    std::cin >> K >> Y;
  }

  std::array<unsigned long long, 100> table;

  table[1] = 1;
  table[2] = 2;

  int k = 2;
  while (k <= 48) {
    table[2 * k] = table[k] * (2 * table[k + 1] - table[k]);
    table[2 * k + 1] = table[k + 1] * table[k + 1] + table[k] * table[k];
  }
}
