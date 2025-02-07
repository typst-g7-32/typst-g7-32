#import "style.typ": gost-style
#import "component/title.typ": title, title-with-boilerplate
#import "title-templates/lib.typ": templates


#let gost(
  ministry: none,
  organization: (full: none, short: none),
  udk: none,
  gos-no: none,
  inventory-no: none,
  performers: none,
  approved-by: (name: none, position: none, year: auto),
  agreed-by: (name: none, position: none, year: auto),
  report-type: "Отчёт",
  about: none, 
  part: none,
  bare-subject: false,
  research: none,
  subject: none,
  stage: none,
  manager: (position: none, name: none),
  city: none,
  year: auto,
  force-outline: true,
  body
) = {
  if year == auto {
    year = int(datetime.today().display("[year]"))
  }

  [#metadata((ministry: ministry, organization: organization, udk: udk, gos-no: gos-no, inventory-no: inventory-no, performers: performers, approved-by: approved-by, agreed-by: agreed-by, report-type: report-type, about: about, part: part, bare-subject: bare-subject, research: research, subject: subject, stage: stage, manager: manager, city: city, year: year)) <document-info>]

  show: gost-style.with(year: year, city: city)

  context if query(<gost-template-used>) == () {
    title(templates.default, body)
    // title-with-boilerplate(query(<document-info>).first().value)
  }

  body
}