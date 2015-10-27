#include <stdio.h>
#include <stdlib.h>

void sort(unsigned int *ptr1, unsigned int *ptr2) {
  if(ptr1 >= ptr2) {
    return;
  }
  unsigned int *start = ptr1;
  unsigned int min = *start;
  ptr1++;
  for(;ptr1 < ptr2; ptr1++) {
    if(*ptr1 < min) {
      *start = *ptr1;
      *ptr1 = min;
      min = *start;
    }
  }
  sort(start + 1, ptr2);
}

int main() { 
  const int table_size = 4;
  unsigned int table[table_size] = { 10,2,0,4 };
  sort(table, table + table_size);
  for(int i=0; i < table_size; i++) {
    printf("%d : %d\n", i, table[i]);
  }
 }
