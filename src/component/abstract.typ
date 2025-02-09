#import "headings.typ": structural-heading-titles


#let get-count(kind, caption) = {
  let target = none
  if kind == page { target = page }
  else { target = figure.where(kind: kind) }
  let count = counter(target).final().first()
  if count == none or count == 0 {
    ""
  } else {
    repr(count) + " " + caption
  }
}

#let abstract(..keywords, body) = {
  [
    #heading(structural-heading-titles.abstract, outlined: false) <abstract>
    
    #context {
      let counts = (get-count(page, "с."), get-count(image, "рис."), get-count(table, "табл."), get-count(ref, "источн."), get-count(none, "прил."))
      counts = counts.filter(it => it != "")
      [Отчёт #counts.join(", ")]
    } // TODO: Добавит расчёт количества источников и приложений

    #{
      set par(first-line-indent: 0pt)
      upper(keywords.pos().join(", "))
    }
  
    #text(body, )
    
    #context {
      let force-outline-query = query(<force-outline>)
      let force-outline = force-outline-query.len() > 0 and force-outline-query.first().value

      if (counter(page).final().first() >= 10 or force-outline) and query(selector(heading)).len() > 0 {
        outline()
      }
    }
  ]
}