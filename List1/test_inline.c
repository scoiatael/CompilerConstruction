static int f(char *c) {
  if (*c < 'a') {
    *c += 'a';
  }
  if (*c < 'A') {
    *c +=  'A';
  }
  if (*c > 'Z' || *c > 'z') {
    return 1;
  }
  return 0;
}

int main() {
  char c = 'a';
  return f(&c);
}
