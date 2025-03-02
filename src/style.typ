#import "component/headings.typ": headings, structural-heading-titles

#let small-text = body => {
  set text(size: 12pt)
  body
}

#let indent = 1.25cm
#let text-size = 14pt

#let gost-style(year: none, city: "", hide-title: false, body) = {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
  )

  set text(
    size: text-size,
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
  show outline.entry: it => {
    show regex("\n"): none
    it
  }

  set ref(supplement: none)
  set figure.caption(separator: " — ")

  set math.equation(numbering: "(1)")

  show figure: pad.with(bottom: 0.5em)

  show image: set align(center)
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
    #align(center)[#{
      if page == 1 {
        if hide-title {} else {[#city #year]}
      } 
      else {page}
    }]
  ])

  set bibliography(style: "gost-r-705-2008-numeric", title: structural-heading-titles.references)
  
  show: headings(text-size, indent)
  body
}
