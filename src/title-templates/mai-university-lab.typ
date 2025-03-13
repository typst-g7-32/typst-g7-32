#import "../component/title.typ": detailed-sign-field
#import "../utils.typ": sign-field

#let template(
    udk: none,
    gos-no: none,
    inventory-no: none,
    performer: none,
    approved-by: (name: none, position: none, year: auto),
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
) = {
    align(left)[
        [Министерство науки и высшего образования Российской Федерации
        Федеральное государственное бюджетное образовательное учреждение
        высшего образования]
        #linebreak()
        #upper("Московский Авиационный Институт")
        #linebreak()
        #([МАИ])
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

    align(center, {
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
        if stage != none {
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
    })

    v(16%)

    if performer != none {
        sign-field(performer.at("name"), performer.at("position"))
    }

    if manager.name != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    pagebreak(weak: true)
}