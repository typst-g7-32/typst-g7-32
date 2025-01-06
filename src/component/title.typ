#import "../style.typ": small-text

#let format-name(name) = {
    return name.replace(" ", "\u{00A0}")
}

#let title(
  institution: "",
  udk: "",
  gos-no: "",
  inventar-no: "",
  approved_by: (name:"", position: ""),
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
) = {
    align(center)[#institution]

    v(25pt)
    
    grid(
        align(left)[
            #if udk != none [УДК: #udk #linebreak()]
            #if gos-no != none [Рег. №: #gos-no #linebreak()]
            #if inventar-no != none [Рег. № ИКРБС: #inventar-no #linebreak()]
        ],
    ) 

    v(15pt)

    if approved_by.name != none and approved_by.position != none {
        align(right)[
            #block(
                width: 250pt,
                table(
                    stroke: none,
                    align: left,
                    inset: (x: 0%),
                    columns: (auto, 5fr, 2fr, 1fr, auto, 5fr),
                    table.cell(colspan: 6)[УТВЕРЖДАЮ],
                    table.cell(colspan: 6)[#approved_by.position],
                    table.cell(colspan: 4)[], table.cell(colspan: 2, align: right)[#format-name(approved_by.name)],
                    table.hline(start: 0, end: 4),
                    table.cell(align: right)[«], [], table.cell(align: left)[»], [], [], table.cell(align: right)[#year],
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

    if manager.name != none and manager.position != none {
        table(
            stroke: none,
            align: bottom,
            columns: (35%, 5%, 1fr, 5%, 20%),
            [#manager.position], [], [], [], [#format-name(manager.name)],
            table.hline(start: 2, end: 3),
            [], [], table.cell(align: center)[#small-text[подпись, дата]], []
        )
    }

    pagebreak(weak: true)
}