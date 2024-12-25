#let structural-heading-titles = ([Введение], [Содержание], [Реферат], [Список исполнителей], [Термины и определения], [Перечень сокращений и обозначений], [Заключение], [Список использованных источников])

#let service-heading = it => {  
  set align(center)
  upper(it)
}

#let headings(text_size, indent) = body => {
  let structural-heading = structural-heading-titles.fold(selector, (acc, i) => {
    acc.or(heading.where(body: i, level: 1))
  })
  
  // TODO: Проверять дубликаты сервисных заголовков и выдавать предупреждение: context query(heading).filter(value => {value.body in service_headings})
  
  set heading(numbering: "1.1.")

  show heading: it => {
    set text(size: text_size)
    if it.body not in structural-heading-titles {
      pad(it, left: indent)
    } else {
      it
    }
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  
  show structural-heading: set heading(numbering: none)
  show structural-heading: it => {
    pagebreak(weak: true)
    service-heading(it)
  }

  show heading: it => {
    it
    ""
    context v(-par.spacing - measure("").height + 0.25cm) 
    // TODO: Исправить отступ в 0.25см, свериться с гостом
  }

  body
}