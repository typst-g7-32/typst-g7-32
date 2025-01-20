#import "../style.typ": sign-field

#let format-name(name) = {
    return name.replace(" ", "\u{00A0}")
}

#let title(
  institution: "",
  udk: "",
  gos-no: "",
  inventory-no: "",
  approval: (name: "", position: "", year: none),
  report_type: "",
  about: "", 
  part: 1, // TODO: Выполнить
  bare-subject: false,
  subject: "",
  is-annotacion: false, // TODO: Выполнить
  stage: (num: 1, type: "промежуточный"), // TODO: Выполнить
  code: "", // TODO: Выполнить
  manager: (position:"", name: ""),
  city: "",
  year: none,
  performer: none,
) = {
    if "year" not in approval.keys() {
        approval.year = year
    }

    align(center)[#institution]

    v(25pt)
    
    grid(
        align(left)[
            #if udk != none [УДК: #udk #linebreak()]
            #if gos-no != none [Рег. №: #gos-no #linebreak()]
            #if inventory-no != none [Рег. № ИКРБС: #inventory-no #linebreak()]
        ],
    ) 

    v(15pt)

    if approval.name != none and approval.position != none {
        align(right)[
            #block(
                width: 250pt,
                table(
                    stroke: none,
                    align: left,
                    inset: (x: 0%),
                    columns: (auto, 5fr, 2fr, 1fr, auto, 5fr),
                    table.cell(colspan: 6)[УТВЕРЖДАЮ],
                    table.cell(colspan: 6)[#approval.position],
                    table.cell(colspan: 4)[], table.cell(colspan: 2, align: right)[#format-name(approval.name)],
                    table.hline(start: 0, end: 4),
                    table.cell(align: right)[«], [], table.cell(align: left)[»], [], [], table.cell(align: right)[#approval.year],
                    table.hline(start: 1, end: 2), table.hline(start: 3, end: 5)
                )
            )
        ]
    } else {
        v(94pt)
    }

    v(25pt)


    align(center)[
        #upper(report_type) \ #upper(about) \ #{if not bare-subject {"по теме:"}} \ #upper(subject)
    ]

    v(20%)

    if performer != none {
        sign-field(performer.at("name"), performer.at("position"))
    }

    if manager.name != none and manager.position != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    pagebreak(weak: true)
}