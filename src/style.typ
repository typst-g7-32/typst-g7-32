#import "component/headings.typ": headings, structural-heading-titles

#let small-text = body => {
  set text(size: 10pt)
  body
}

#let indent = 1.25cm
#let text-size = 12pt

#let gost-style(year: none, city: "", body) = {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )

  set text(
    size: text-size,
    lang: "ru",
    hyphenate: false
  )

  set outline(indent: auto)

  set par(
    justify: true,
    first-line-indent: indent,
  )

  set ref(supplement: none)
  set figure.caption(separator: " — ")

  set math.equation(numbering: "(1)")

  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  show figure.caption.where(kind: table): set align(left)
  show table.cell: set align(left)

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
  
  show: headings(text-size, indent)
  body
}
