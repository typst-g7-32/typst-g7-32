#import "style.typ": gost-style
#import "component/title.typ": title-template as title, title-templates, title-with-boilerplate
#import "component/performers.typ": fetch-performers


#let gost(
  ministry-name: none,
  organization: (full: none, short: none),
  udk: none,
  gos-no: none,
  inventory-no: none,
  performers: (),
  approved-by: (name: none, position: none, year: none), // TODO: year: auto
  agreed-by: (name: none, position: none, year: none),
  report-type: "Отчёт",
  about: none, 
  part: none,
  bare-subject: false,
  research: none,
  subject: none,
  stage: none,
  manager: (position: none, name: none),
  city: none,
  year: none, 
  body
) = {
  assert(subject != none, message: "Не задана тема работы")
  assert(city != none, message: "Не задан город")

  if year == none { 
    year = int(datetime.today().display("[year]"))
  }

  let performers = fetch-performers(performers)

  [#metadata((ministry-name: ministry-name, organization: organization, udk: udk, gos-no: gos-no, inventory-no: inventory-no, performers: performers, approved-by: approved-by, agreed-by: agreed-by, report-type: report-type, about: about, part: part, bare-subject: bare-subject, research: research, subject: subject, stage: stage, manager: manager, city: city, year: year)) <document-info>]

  show: gost-style.with(year: year, city: city)

  context if query(<gost-template-used>) == () {
    title-with-boilerplate(query(<document-info>).first().value)
  }

  body
}

// TODO: Ограничить область видимости