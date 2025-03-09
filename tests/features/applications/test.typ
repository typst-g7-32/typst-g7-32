#import "/src/export.typ": gost, annexes, annex-heading

#show: gost.with(hide-title: true, force-outline: true)

#show: annexes

= Приложение с элементами
Ссылка на рисунок @example-image.

#figure(
  image("/tests/assets/nature.jpg", width: 50%),
  caption: "Пример изображения"
) <example-image>

Ссылка на рисунок @another-image.

#figure(
  image("/tests/assets/home.jpg", width: 50%),
  caption: "Пример изображения"
) <another-image>

Ссылка на таблицу @example-table.

#figure(
  table(
    columns: 4,
    table.header(
      [Заголовок 1], [Заголовок 2], [Заголовок 3], [Заголовок 4]
    ),
    [Элемент 1], [Элемент 2], [Элемент 3], [Элемент 4],
    [Элемент 5], [Элемент 6], [Элемент 7], [Элемент 8],
    [Элемент 9], [Элемент 10], [Элемент 11], [Элемент 12]
  ),
  caption: "Таблица с заголовками"
) <example-table>

Ссылка на листинг @example-code.

#figure(
  ```cpp
  #include <iostream>

  int main() {
      std::cout << "Hello, world!" << std::endl;
      return 0;
  }
  ```,
  caption: [Пример кода на C++]
) <example-code>

== Заголовок приложений второго уровня

Ссылка на рисунок @third-image.

#figure(
  image("/tests/assets/abstract.jpg", width: 50%),
  caption: "Пример изображения"
) <third-image>

= Заголовок приложения

== Очередной заголовок приложения

#annex-heading("вспомогательное", level: 2)[Приложение с указанием статуса второго уровня]

#annex-heading("основное", level: 1)[Приложение с указанием статуса]
