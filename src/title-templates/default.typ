#import "../component/title.typ": detailed-sign-field
#import "../utils.typ": sign-field

#let template(
    ministry: none,
    organization: (full: none, short: none),
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
    force-outline: false,
) = {
    align(center)[
        #ministry\
        #upper(organization.full)\
        #(upper(organization.short))
    ]

    v(15pt)

    grid(
        align(left)[
            #if udk != none [УДК: #udk\ ]
            #if gos-no != none [Рег. №: #gos-no\ ]
            #if inventory-no != none [Рег. № ИКРБС: #inventory-no\ ]
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
        [\ ]
        upper(about)
        if research != "" {
            [\ #research]
        }
        [\ ]
        if not bare-subject {
            [по теме:]
        }
        [\ ]
        upper(subject)
        if stage != none {
            [\ (#stage.type]
            if stage.num != none {
                [, этап #stage.num]
            }
            [)]
        }
        if part != none {
            [\ \ Книга #part]
        }
    })

    v(16%)

    if performer != none { // TODO: Указать как исполнителя
        sign-field(performer.at("name"), performer.at("position"))
    }

    if manager.name != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    pagebreak(weak: true)
}