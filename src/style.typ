#let indent = 1.25cm
#let text_size = 14pt

#let default = body => {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )
  
  set heading(numbering: "1.1.")

  set text(
    font: "Times New Roman",
    size: text_size,
    lang: "ru",
    hyphenate: false
  )

  show heading: it => {
    // TODO: Исправить расстояние снизу
    set text(size: text_size)
    set block(above: 1.25cm, below: 0.75cm)
    pad(left: indent, it)
    ""
    v(-1cm)
  }

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