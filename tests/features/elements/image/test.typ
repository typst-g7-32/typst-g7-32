#import "/src/export.typ": gost

#show: gost.with(hide-title: true)

Ссылка на рисунок @example-image и ещё на рисунок @another-image.

#figure(
  image("/tests/assets/abstract.jpg", width: 55%),
  caption: "Пример изображения"
) <example-image>

#figure(
  image("/tests/assets/home.jpg", width: 55%),
  caption: "Другой пример изображения"
) <another-image>