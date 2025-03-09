#import "../../../../src/export.typ": gost

#show: gost.with(hide-title: true)

Пример блока кода представлен на листинге @example-code:

#figure(
  ```cpp
  #include <iostream>
  #include <unordered_map>

  // Функция для вычисления чисел Фибоначчи с мемоизацией
  int fibonacci(int n, std::unordered_map<int, int>& memo) {
      if (memo.find(n) != memo.end()) {
          return memo[n];
      }
      if (n <= 1) {
          return n;
      }
      memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
      return memo[n];
  }

  int main() {
      std::unordered_map<int, int> memo;
      int n = 10;
      std::cout << "Fibonacci number at position " << n << " is " << fibonacci(n, memo) << std::endl;
      return 0;
  }
  ```,
  caption: [Пример кода на C++: вычисление чисел Фибоначчи с мемоизацией]
) <example-code>