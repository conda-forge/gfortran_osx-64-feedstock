#include <iostream>

extern "C" void print_hello(void);

using namespace std;

int main() {
    print_hello();
    cout << "Hello from C++" << endl;
    return 0;
}
