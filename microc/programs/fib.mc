fib(x) {
    if (x < 2) return 1;
    return fib(x - 1) + fib(x - 2);
}

main() {
    print(fib(2));
    print(fib(5));
}
