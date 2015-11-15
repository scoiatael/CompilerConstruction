#include <stdio.h>
#include <stdlib.h>

struct tree
{
  double x;
  double y;
  struct tree* left;
  struct tree* right;
};

const double* find(double x, const struct tree* t) {
  if(t == NULL) {
    return NULL;
  }
  if(t->x == x) {
    return &t->y;
  }
  if(x < t->x) {
    return find(x, t->left);
  } else {
    return find(x, t->right);
  }
}

int main() {
  struct tree t1, t2, t3;
  t1.x = 1;
  t1.y = 10;
  t2.x = 2;
  t2.y = 20;
  t3.x = 3;
  t3.y = 30;
  t3.left = &t1;
  t3.right = &t2;
  const double *found = find(1, &t3);
  if(found == NULL) {
    printf("Not found\n");
  } else {
    printf("Found: %f\n", *found);
  }
}
