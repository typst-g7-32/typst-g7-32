#import "/src/export.typ": gost

#show: gost.with(hide-title: true)

Представлено на таблице @table.


#let a = (for i in range(0, 250) {
  ([Ячейка #(i+1)], )
}).flatten()

#let heading = table.header(
  ..(for i in range(0, 5) {
    (text(weight: "bold")[Заголовок #(i+1)], )
  })
)

#figure(
  table(
    columns: 5,
    heading,
    ..a,
  ),
  caption: "Таблица с заголовками"
) <table>