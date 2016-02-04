MicroC
===

A compiler for a simple C-like language as taught in the PLT class.

```c
gcd(a, b) {
    while (a != b) {
        if (a > b) a = a - b;
        else b = b - a;
    }
    return a;
}

main() {
    print(gcd(2, 14));
    print(gcd(3, 15));
    print(gcd(99,121));
}
```
