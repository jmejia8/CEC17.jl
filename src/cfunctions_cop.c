// Compile: gcc -shared -fpic -lm -Wall -Ofast -march=native  cfunctions_cop.c -o cfunctions_cop.so

#include "./cec17_test_COP.cpp"


double *OShift,*M,*M1,*M2,*y,*z,*z1,*z2;
int ini_flag,n_flag,func_flag,f5_flag;
char* dataDir;

void func(double *x, double *f, double *g, double *h, char* dir, int nx, int mx, int func_num){
	dataDir = dir;
	cec17_test_COP(x, f, g, h, nx, mx, func_num);
}