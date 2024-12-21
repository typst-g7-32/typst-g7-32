#let indent = 1.25cm
#let text_size = 14pt

// TODO: Подтягивать особое форматирование заголовка при обычном вводе (=Введение) или выделить под специальные части содержания отдельные функции?
#let service_headings = ("введение", "заключение")

#let service-heading = it => {
  set align(center)
  upper(it)
}

#let default = body => {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )

  set text(
    font: "Times New Roman",
    size: text_size,
    lang: "ru",
    hyphenate: false
  )

  set heading("1.1")
  // TODO: Исплючить сервисные заголовки из нумерации

  show heading: it => {
    // TODO: Исправить расстояние снизу
    set text(size: text_size)
    set block(above: 1.25cm, below: 0.75cm)
    if (not it.outlined or (lower(it.body.text) in service_headings and it.level == 1)) {
      service-heading(it)
    } else {
      pad(left: indent, it)
    }
    ""
    v(-1cm)
  }

  set outline(indent: auto)

  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: indent,
  )
  
  set page(footer: context [
      #let page = here().page()
      #let current_year = datetime.today()
      #align(center)[
          #if page == 1 {"Москва " + current_year.display("[year]")} else {page}
      ]
  ])

  body
}


#let small-text = body => {
  set text(size: 12pt)
  body
}