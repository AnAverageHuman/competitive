#include <cmath>
#include <iostream>
#include <sstream>

int main() {
  int P;
  std::cin >> P;

  for (int i = 0; i < P; i++) {
    int K, B;
    std::cin >> K >> B;

    int lines = ::ceil(B / 40.0);
    std::string line;
    std::string line2;
    for (int j = 0; j < lines; j++) {
      std::cin >> line2;
      line += line2;
    }

    std::vector<std::string> output;

    int pos = line.size() - 2;

    while (pos > 0) {
      std::string byte = line.substr(pos, 2);
      int newpos = pos;
      while (byte == line.substr(newpos - 2, 2)) {
        newpos -= 2;
      }
      if (pos - newpos >= 6) {
        output.push_back(dec2hex((pos - newpos) / 2));
      } else {
        output << byte;
      }

      pos += newpos + 2;
    }

    std::cout << K << ' ' << output.str().length() / 2 << std::endl;
    int k = 0;
    if (output.str().length() > 80) {
      for (; k < output.str().length() - 80; k += 80) {
        std::cout << output.str().substr(k, 80) << std::endl;
      }
    }
    std::cout << output.str().substr(k) << std::endl;
  }
}
