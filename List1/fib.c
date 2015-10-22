int fib(int n) {
  if(n > 1) {
    return fib(n-2) + fib(n-1);
  } else {
    return 1;
  }
}

int fib2_aux(int n, int fibn_1, int fib_n2) {
  switch(n) {
  case 0: return fib_n2; break;
  case 1: return fibn_1; break;
  default: return fib2_aux(n-1, fibn_1 + fib_n2, fibn_1);
  }
}

int fib2(int n) {
  return fib2_aux(n, 1, 1);
}

int main() {}
