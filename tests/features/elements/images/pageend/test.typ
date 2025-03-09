#import "../../../../../src/export.typ": gost

#show: gost.with(hide-title: true)

#lorem(56)

Представлено на рисунке @example-image.

#figure(
  image("../../../../../template/images/picture.jpg"),
  caption: "Пример изображения"
) <example-image>