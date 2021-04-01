#include <cmath>
#include <iostream>
#include <sstream>

int hex2dec(std::string str) {
  int result = 0;
  for (char &c : str) {
    result *= 16;
    if (isalpha(c)) {
      result += c - 'A' + 10;
    } else {
      result += c - '0';
    }
  }
  return result;
}

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

    std::stringstream output;

    int pos = 0;
    while (pos < line.size()) {
      // std::cout << output.str() << std::endl;
      int byte = hex2dec(line.substr(pos, 2));
      pos += 2;
      if ((byte >> 7) & 1) {
        int repeats = (byte & 0b01111111) + 3;
        for (int k = 0; k < repeats; k++) {
          output << line.substr(pos, 2);
        }
        pos += 2;
      } else {
        int literals = byte + 1;
        for (int k = 0; k < literals; k++) {
          output << line.substr(pos, 2);
          pos += 2;
        }
      }
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
