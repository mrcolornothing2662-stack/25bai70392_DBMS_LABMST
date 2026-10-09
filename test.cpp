#include <iostream>
using namespace std;

int main() {
    int a[] = {4, 3, 7, 8, 6, 2, 1};
    int n = 7;

    for (int i = 0; i < n - 1; i++) {
        if (i % 2 == 0 && a[i] > a[i + 1])
            swap(a[i], a[i + 1]);

        if (i % 2 == 1 && a[i] > a[i + 1])
            swap(a[i], a[i + 1]);
    }

    for (int i = 0; i < n; i++)
        cout << a[i] << " ";
}
