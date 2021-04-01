// Doesn't really work

#include <stdio.h>
#include <stdlib.h>

int W, H, L, U, R, D;
double **memo = NULL;

double recsolve(int x, int y) {
  if (x > W || y > H) {
    return 0;
  }

  if (memo[x][y] != -1) {
    return memo[x][y];
  }

  if (x == W) {
    memo[x][y] = recsolve(x, y + 1);
  } else if (y == H) {
    memo[x][y] = recsolve(x + 1, y);
  } else {
    double rs = recsolve(x, y + 1) + recsolve(x + 1, y);
    memo[x][y] = rs / 2;
  }

  return memo[x][y];
}

void solve(int c) {
  memo = calloc(sizeof *memo, W + 1);

  for (int i = 0; i < W + 1; i++) {
    memo[i] = calloc(sizeof **memo, H + 1);
  }

  for (int i = 0; i <= W; i++) {
    for (int j = 0; j <= H; j++) {
      if (i < L || i > U || j < R || j > D) {
        memo[i][j] = -1;
      }
    }
  }

  memo[W][H] = 1;
  double p = recsolve(1, 1);
  printf("Case #%d: %f\n", c, p);
  for (int i = 0; i < W + 1; i++) {
    for (int j = 0; j < H + 1; j++) {
      printf("%f ", memo[i][j]);
    }
    printf("\n"); }

  for (int i = 0; i < W + 1; i++) {
    free(memo[i]);
  }

  free(memo);
  memo = NULL;
}

int main() {
  int T;
  scanf("%d", &T);

  for (int c = 1; c <= T; c++) {
    scanf("%d %d %d %d %d %d", &W, &H, &L, &U, &R, &D);
    solve(c);
  }
}
