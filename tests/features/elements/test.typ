#import "../../../src/export.typ": gost

#show: gost.with(hide-title: true)

= Таблицы

Для создания таблиц используется функция `table()`, обёрнутая в макрос `#figure` для добавления подписи. Пример показан на таблице @example-table.

#figure(
  table(
    columns: 4,
    table.header(
      [Заголовок 1], [Заголовок 2], [Т], [Заголовок 4]
    ),
    [Проверка], [Проверка], [Проверка], [Проверка],
    [Проверка], [Проверка], [Проверка], [Проверка],
  ),
  caption: [Пример таблицы с данными]
) <example-table>

#lorem(100)

= Блоки кода

Чтобы оформить блоки кода в документе, можно использовать синтаксис, похожий на Markdown. Пример указан на листинге @example-code:

#figure(
  ```typst
  // Пример кода на Typst:
  #import "package.typ"

  // Функция вывода сообщения
  print("Hello, world!")
  ```,
  caption: [Пример кода на Typst]
) <example-code>

#lorem(100)

= Формулы

Чтобы оформить формулы в документе, можно использовать синтаксис typst-math. Примеры демонстрируют использование формул в шаблоне: 

Формула @example-formula-first показывает как применять сложные функции, формула  @example-formula-second демонстрирует как можно оформить матрицы, а формула @example-formula-third – использование типов и обозначений.


$ sum_(k=0)^n k = 1 + ... + n = (n(n+1)) / 2 $
<example-formula-first>


$ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) * x = pi * psi(alef/x) $ 
<example-formula-second>

$ cal(A) := { x in RR | x "натуральное" } $
<example-formula-third>

#lorem(100)

= Изображения

Изображения добавляются с помощью функции `image()` внутри макроса `#figure`. Пример вставки изображения указан на рисунке @example-image.

#figure(
  image("images/picture.jpg", width: 60%),
  caption: "Пример изображения"
) <example-image>

#lorem(100)