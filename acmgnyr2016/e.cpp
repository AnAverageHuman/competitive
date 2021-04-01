#include <array>
#include <iostream>

std::array<std::array<int, 100>, 101> table;

void pdc(int n, int v) {
  if (v == 0) {
    table[n][v] = 1;
    return;
  }

  if (table[n][v] > 0) {
    return;
  }

  table[n][v] =
      (table[n - 1][v - 1] * (n - v) + table[n - 1][v] * (v + 1)) % 1001113;
}

void solve(int K, int N, int V) {
  for (int n = 2; n <= N; n++) {
    for (int v = 0; v <= N; v++) {
      pdc(n, v);
    }
  }

  std::cout << K << " " << table[N][V] << std::endl;
}

int main() {
  table[2][1] = 1;

  int P;
  int K, N, V;

  std::cin >> P;
  for (int i = 0; i < P; i++) {
    std::cin >> K >> N >> V;
    solve(K, N, V);
  }
}
