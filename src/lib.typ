#import "component/title.typ": title
#import "style.typ": gost-style

#let gost(
  institution: none,
  udk: none,
  gos-no: none,
  inventar-no: none,
  approved_by: (name: none, position: none),
  report_type: "Отчёт",
  about: none, 
  part: 1,
  bare-subject: false,
  subject: none,
  is-annotacion: false,
  stage: (num: 1, type: "промежуточный"),
  code: none,
  manager: (position: none, name: none),
  city: none,
  year: none, 
  body
) = {
  if institution == none {panic("Не задана организация")}
  if subject == none {panic("Не задана тема работы")}
  if city == none {panic("Не задан город")}
  if year == none { 
    year = datetime.today().display("[year]")
  }
  show: gost-style.with(year: year, city: city)
  title(institution: institution, udk: udk, gos-no: gos-no, inventar-no: inventar-no, approved_by: approved_by, report_type: report_type, about: about, part: part, bare-subject: bare-subject, subject: subject, is-annotacion: is-annotacion, stage: stage, code: code, manager: manager, city: city, year: year)
  context {
    if query(selector(heading)).len() > 0 {
      outline()
    }
  }
  body
}

#let performer(name, position) = {
  return table(
    stroke: none,
    align: bottom,
    columns: (35%, 5%, 1fr, 4%, 30%),
    [#position], [], [], [], [#name],
    table.hline(start: 2, end: 3),
  )
}

// TODO: Ограничить область видимости