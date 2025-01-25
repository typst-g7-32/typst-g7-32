#import "../style.typ": sign-field
#import "../utils.typ": fetch-field, unbreak-name
#import "performers.typ": performers-page


#let detailed-sign-field(title, name, position, year) = {
    table(
        stroke: none,
        align: left,
        inset: (x: 0%),
        columns: (8pt, 1fr, 8pt, 10pt, 2fr, auto, 25pt),
        table.cell(colspan: 7)[#upper(title)],
        table.cell(colspan: 7)[#position],
        table.cell(colspan: 5)[], table.cell(colspan: 2, align: right)[#unbreak-name(name)],
        table.hline(start: 0, end: 5),
        table.cell(align: right)[«], [], table.cell(align: left)[»], [], [], [], table.cell(align: right)[#year],
        table.hline(start: 1, end: 2), table.hline(start: 4, end: 6)
    )
}

#let title-element(
  ministry-name: none,
  organization: (full: none, short: none),
  udk: none,
  gos-no: none,
  inventory-no: none,
  approved-by: (name: none, position: none, year: none),
  agreed-by: (name: none, position: none, year: none),
  report-type: none,
  about: none, 
  bare-subject: false,
  research: none,
  subject: none,
  stage: (type: none, num: none),
  part: none,
  manager: (position: none, name: none),
  city: none,
  year: none,
  performer: none,
) = {
    organization = fetch-field(organization, ("full*", "short"), "организации")
    approved-by = fetch-field(approved-by, ("name", "position", "year"), "утверждения")
    agreed-by = fetch-field(agreed-by, ("name", "position", "year"), "согласования")
    stage = fetch-field(stage, ("type", "num"), "этапа")
    manager = fetch-field(manager, ("position", "name"), "руководителя")

    if "year" not in approved-by.keys() {
        approved-by
.year = year
    }

    // TODO: Заменить на шаблон

    align(center)[
        #ministry-name
        #linebreak()
        #upper(organization.full)
        #linebreak()
        (#upper(organization.short))
    ]

    v(15pt)
    
    grid(
        align(left)[
            #if udk != none [УДК: #udk #linebreak()]
            #if gos-no != none [Рег. №: #gos-no #linebreak()]
            #if inventory-no != none [Рег. № ИКРБС: #inventory-no #linebreak()]
        ],
    ) 

    v(15pt)

    grid(
        columns: (1fr, 1fr),
        align: (left, right),
        gutter: 20%,
        if approved-by.name != none [
            #detailed-sign-field("согласовано", approved-by.name, approved-by.position, approved-by.year)
        ],
        if agreed-by.name != none [
            #detailed-sign-field("утверждаю", agreed-by.name, agreed-by.position, agreed-by.year)
        ],
    )

    v(30pt)

    align(center)[#{
        upper(report-type)
        linebreak()
        upper(about)
        if research != "" {
            linebreak()
            [#research]
        }
        linebreak()
        if not bare-subject {
            [по теме:]
        }
        linebreak()
        upper(subject)
        if stage != (type: none, num: none) {
            linebreak()
            [(#stage.type]
            if stage.num != none {
                [, этап #stage.num]
            }
            [)]
        }
        if part != none {
            linebreak()
            linebreak()
            [Книга #part]
        }
    }]

    v(16%)

    if performer != none {
        sign-field(performer.at("name"), performer.at("position"))
    }

    if manager.name != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    pagebreak(weak: true)
}

#let title-with-boilerplate(document-info) = {
    // TODO: Вынести список исполнителей и содержание, чтобы при выключении титульника они не пропадали

    let title-performer = none
    if document-info.performers.len() == 1 { // 5.2.2
        title-performer = document-info.performers.at(0)
    }
    
    let title-info = (:)
    for (key, value) in document-info {
        if key != "performers" { title-info.insert(key, value) }
    }
    title-info.insert("performer", title-performer)
    title-element(..title-info)

    if title-performer == none and document-info.performers.len() > 0 {
      performers-page(document-info.performers)
    }

    context if query(selector(heading)).len() > 0 {
      outline()
    }
}

#let title-templates = (
    default: "default",
    mai-university-lab: "mai-university-lab", 
)

#let title-template(template, body, ..arguments) = context {
  let document-info = query(<document-info>)
  assert(document-info.len() != 0, message: "В документе отсутствует информация о структуре заголовка, добавьте #show gost.with ...")
  assert(document-info.len() == 1, message: "В документе не должно быть более одной информации о структуре заголовка, возможно вы несколько раз продублировали команду #show gost.with ...")
  [#metadata(none) <gost-template-used>]
  if template == none {

  } else if template == title-templates.default {
    title-with-boilerplate(document-info.first().value)
  }
  // TODO: Подключать шаблоны
  body
}