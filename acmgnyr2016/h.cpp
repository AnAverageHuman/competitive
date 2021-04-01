#include <algorithm>
#include <iostream>
#include <vector>

struct my_int {
  int i;
  bool used;
};

std::vector<int> vec;

int find(int elem, std::vector<my_int> &myint, int start) {
  for (size_t i = start; i < myint.size(); i++) {
    if (myint[i].i == elem && !myint[i].used) {
      myint[i].used = true;
      return i;
    }
  }

  return -99999;
}

void solve(int K, int N) {
  std::vector<my_int> myint;
  for (int i : vec) {
    myint.push_back({i, false});
  }

  std::vector<int> vec_sorted = vec;
  std::sort(vec_sorted.begin(), vec_sorted.end());

  int last_pos = 0;
  int count = 0;
  for (int i : vec_sorted) {
    last_pos = find(i, myint, last_pos);

    if (last_pos == -99999) {
      break;
    }

    count++;
  }

  int ans = N - count;

  std::cout << K << " " << ans << std::endl;
}

int main() {
  int P;
  int K, N;
  int x;

  std::cin >> P;
  for (int i = 0; i < P; i++) {
    std::cin >> K >> N;

    for (int j = 0; j < N; j++) {
      std::cin >> x;
      vec.push_back(x);
    }

    solve(K, N);
    vec.clear();
  }
}
