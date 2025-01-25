#import "component/headings.typ": headings
#import "utils.typ": unbreak-name

#let small-text = body => {
  set text(size: 10pt)
  body
}

#let sign-field(name, position, details: "подпись, дата") = {
  return table(
    stroke: none,
    align: bottom,
    columns: (35%, 5%, 1fr, 5%, 20%),
    [#position], [], [], [], [#unbreak-name(name)],
    table.hline(start: 2, end: 3),
    [], [], table.cell(align: center)[#small-text[#details]], []
  )
}

#let indent = 1.25cm
#let text-size = 12pt

#let gost-style(year: none, city: "", body) = {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )

  set text(
    font: "Times New Roman",
    size: text-size,
    lang: "ru",
    hyphenate: false
  )

  set outline(indent: auto)

  set par(
    justify: true,
    first-line-indent: indent,
  )
  
  set page(footer: context [
      #let page = here().page()
      #align(center)[
          #if page == 1 {[#city #year]} else {page}
      ]
  ])
  
  show: headings(text-size, indent)
  body
}
