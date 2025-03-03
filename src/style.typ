#import "component/headings.typ": headings, structural-heading-titles

#let small-font-state = state("size", none)

/*#let small-text = body => {
  set text(size: 12pt)
  body
}*/

#let small-text = body => context {
  set text(size: small-font-state.get())
  body
}

#let gost-style(year: none, city: "", font-size: 13pt, small-font-size: 10pt, indent: 1.5cm, hide-title: true, body) = {

  small-font-state.update(x => small-font-size)

  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )

  set text(
    size: font-size,
    lang: "ru",
    hyphenate: false
  )

  set par(
    justify: true,
    first-line-indent: (
      amount: indent,
      all: true,
    ),
    spacing: 1.5em
  )

  set outline(indent: indent, depth: 3)
  show outline: set block(below: indent / 2)

  set ref(supplement: none)
  set figure.caption(separator: " — ")

  set math.equation(numbering: "(1)")

  show figure: pad.with(bottom: 0.5em)
  show figure.where(kind: image): set figure(supplement: [Рисунок])

  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  show figure.caption.where(kind: table): set align(left)
  show table.cell: set align(left)

  set list(marker: [–], indent: indent, spacing: 1em)
  set enum(indent: indent, spacing: 1em)

  // TODO: Расположить table.header по центру
  let table-header(..headers) = {
    table.header(..headers.pos().map(it => {
      set text(weight: "bold")
      it
    }))
  }
  
  set page(footer: context [
    #let page = here().page()
    #align(center)[
        #if page == 1 {[#city #year]} else {page}
    ]
  ])

  set bibliography(style: "gost-r-705-2008-numeric", title: structural-heading-titles.references)
  
  show: headings(font-size, indent)
  body
}