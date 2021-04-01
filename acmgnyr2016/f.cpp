#include <array>
#include <bitset>
#include <iostream>
#include <string>
#include <utility>

void printSudoku(int K,
                 std::array<std::array<std::pair<int, int>, 6>, 6> &sudoku) {
  std::cout << K << std::endl;
  for (const std::array<std::pair<int, int>, 6> &row : sudoku) {
    for (const std::pair<int, int> &p : row) {
      if (p.second) {
        std::cout << p.first << "/" << p.second << " ";
      } else {
        std::cout << p.first << " ";
      }
    }
    std::cout << std::endl;
  }
}

std::array<int, 3>
firstAvailable(std::array<std::array<std::pair<int, int>, 6>, 6> &sudoku) {
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 6; j++) {
      if (sudoku[i][j].first == -1) {
        return {i, j, 1};
      }

      if (sudoku[i][j].second == -1) {
        return {i, j, 2};
      }
    }
  }

  return {6, 6, 6};
}

std::bitset<10>
findConstraints(std::array<std::array<std::pair<int, int>, 6>, 6> &sudoku,
                int x, int y) {
  std::bitset<10> ret;
  for (int i = 0; i < 6; i++) {
    if (sudoku[x][i].first > 0) {
      ret[sudoku[x][i].first] = 1;
    }

    if (sudoku[x][i].second > 0) {
      ret[sudoku[x][i].second] = 1;
    }
  }

  for (int i = 0; i < 6; i++) {
    if (sudoku[i][y].first > 0) {
      ret[sudoku[i][y].first] = 1;
    }

    if (sudoku[i][y].second > 0) {
      ret[sudoku[i][y].second] = 1;
    }
  }

  for (int i = x / 2 * 2; i < x / 2 * 2 + 2; i++) {
    for (int j = y / 3 * 3; j < y / 3 * 3 + 3; j++) {
      if (sudoku[i][j].first > 0) {
        ret[sudoku[i][j].first] = 1;
      }

      if (sudoku[i][j].second > 0) {
        ret[sudoku[i][j].second] = 1;
      }
    }
  }

  return ret;
}

bool solve(int K, std::array<std::array<std::pair<int, int>, 6>, 6> &sudoku) {
  std::array<int, 3> coords = firstAvailable(sudoku);
  if (coords == std::array<int, 3>{6, 6, 6}) {
    return true;
  }

  std::bitset<10> constraints = findConstraints(sudoku, coords[0], coords[1]);
  std::pair<int, int> firstsecond = sudoku[coords[0]][coords[1]];
  for (int i = 1; i < 10; i++) {
    std::pair<int, int> &box = sudoku[coords[0]][coords[1]];
    if (!constraints[i] &&
        (box.second == -1 || box.second == 0 || i < box.second) &&
        (box.first == -1 || i > box.first)) {
      if (coords[2] == 1) {
        box.first = i;
      } else {
        box.second = i;
      }

      if (solve(K, sudoku)) {
        return true;
      }
    }

    sudoku[coords[0]][coords[1]] = firstsecond;
  }

  return false;
}

int main() {
  int P;
  int K;
  std::cin >> P;
  for (int i = 0; i < P; i++) {
    std::cin >> K;
    std::string s;
    std::array<std::array<std::pair<int, int>, 6>, 6> sudoku;
    for (int i = 0; i < 36; i++) {
      std::cin >> s;
      if (s.find('/') != std::string::npos) {
        int first, second;
        first = (s[0] == '-') ? -1 : s[0] - '0';
        second = (s[2] == '-') ? -1 : s[2] - '0';
        sudoku[i / 6][i % 6] = {first, second};
      } else {
        if (s[0] == '-') {
          sudoku[i / 6][i % 6] = {-1, 0};
        } else {
          sudoku[i / 6][i % 6] = {s[0] - '0', 0};
        }
      }
    }
    solve(K, sudoku);
    printSudoku(K, sudoku);
  }
}
