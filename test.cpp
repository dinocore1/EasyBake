
#include <iostream>

using namespace std;

extern "C" void hello(int t);

int main() {
	cout << "Hello World" << endl;
	hello(5);
	return 0;
}