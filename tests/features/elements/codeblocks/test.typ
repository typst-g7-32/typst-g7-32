#import "../../../../src/export.typ": gost

#show: gost.with(hide-title: true)

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