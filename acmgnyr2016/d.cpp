#include <iostream>
#include <vector>

void solve(int K, int N) {
  int n = N;
  std::vector<int> lefts;
  while (n > 1) {
    if (n % 2 == 0) {     // even
      lefts.push_back(0); // 0: left; 1: right
    } else {
      lefts.push_back(1);
    }

    n /= 2;
  }

  size_t num = 1;
  size_t denom = 1;
  for (int i = lefts.size() - 1; i >= 0; i--) {
    if (lefts[i] == 0) {
      denom = num + denom;
    } else {
      num = num + denom;
    }
  }

  std::cout << K << " " << num << "/" << denom << std::endl;
}

int main() {
  int P;
  int K, N;

  std::cin >> P;
  for (int i = 0; i < P; i++) {
    std::cin >> K >> N;
    solve(K, N);
  }
}
