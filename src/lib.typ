#import "style.typ": gost-style
#import "component/title.typ": title
#import "component/performers.typ": performers-page, fetch-performers

#let gost(
  institution: none,
  udk: none,
  gos-no: none,
  inventory-no: none,
  performers: (),
  approval: (name: none, position: none, year: none),
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
    year = int(datetime.today().display("[year]"))
  }

  let performers = fetch-performers(performers)

  let title-performer = none
  if performers.len() == 1 { // 5.2.2
    title-performer = performers.at(0)
  }

  show: gost-style.with(year: year, city: city)

  title(institution: institution, udk: udk, gos-no: gos-no, inventory-no: inventory-no, approval: approval, report_type: report_type, about: about, part: part, bare-subject: bare-subject, subject: subject, is-annotacion: is-annotacion, stage: stage, code: code, manager: manager, city: city, year: year, performer: title-performer)

  if title-performer == none and performers.len() > 0 {
    performers-page(performers)
  }

  context if query(selector(heading)).len() > 0 {
    outline()
  }
  
  body
}

// TODO: Ограничить область видимости