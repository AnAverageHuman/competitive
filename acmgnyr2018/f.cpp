#include <algorithm>
#include <cmath>
#include <iostream>
#include <vector>

void solve(int K, int n, int k, double P_left, double P_right) {
  std::vector<double> probs(n, 0);
  probs[0] = 1;
  double win = 0;
  while (*std::max_element(probs.begin(), probs.end()) > 1e-10) {
    std::vector<double> probs_next(n, 0);
    for (int i = 0; i < n; ++i) {
      double sub_right = P_right * probs[i];
      probs_next[(i - 1 + n) % n] += sub_right;
      double sub_left = P_left * probs[i];
      probs_next[(i + 1) % n] += sub_left;
    }
    win += (1 - P_left - P_right) * probs[k];
    probs = probs_next;
  }

  std::printf("%d %.2f\n", K, win * 100);
}

int main() {
  int P;
  int K;
  int k, n;
  double P_left, P_right;
  std::cin >> P;

  for (int i = 0; i < P; i++) {
    std::cin >> K >> n >> k >> P_left >> P_right;
    solve(K, n, k, P_left, P_right);
  }
}
