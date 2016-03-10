gcd(a, b) {
    while (a != b) {
        if (a > b) a = a - b;
        else b = b - a;
    }
    return a;
}

main() {
    print(gcd(2, 14) == 2);
}
