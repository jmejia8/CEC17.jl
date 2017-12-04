// Compile: gcc -shared -fpic -lm -Wall -Ofast -march=native  cfunctions.c -o cfunctions.so

#include "./cec17_test_func.cpp"


double *OShift,*M,*y,*z,*x_bound;
int ini_flag=0,n_flag,func_flag,*SS;

void func(double* x, double* f, int n, int m, int func_num, int* evals_ptr){
	cec17_test_func(x, f, n, m, func_num);
}