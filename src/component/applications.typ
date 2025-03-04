#import "@preview/numberingx:0.0.1": formatter

#let is-heading-in-application(heading) = state("applications", false).at(heading.location())

#let get-element-numbering(current-heading-numbering, element-numbering) = {
  let current-numbering = formatter("{upper-russian}.{1}")(current-heading-numbering.first())
  formatter(str(current-numbering)+".{1}")(element-numbering)
}

#let application-heading(status, level: 1, body) = {
  heading(level: level)[(#status)\ #body]
}

#let applications(content) = {
  set heading(
    numbering: formatter("{upper-russian}.{1}"),
    hanging-indent: 0pt
  )

  show heading: set align(center)
  show heading: it => {
    block[#upper([приложение]) #numbering(it.numbering, ..counter(heading).at(it.location())) \ #text(weight: "medium")[#it.body]]
  }

  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)

    pagebreak(weak: true)
    it
  }

  set figure(numbering: it => context {
    let current-heading = counter(heading).get()
    get-element-numbering(current-heading, it)
  })

  set math.equation(numbering: it => context {
    let current-heading = counter(heading).get()
    [(#get-element-numbering(current-heading, it))]
  })

  state("applications").update(true)
  counter(heading).update(0)
  content
}