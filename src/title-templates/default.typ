#import "../component/title.typ": detailed-sign-field
#import "../utils.typ": sign-field
#import "utils.typ": if-present, per-line

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
    force-performers: false,
    force-outline: false,
) = {
    per-line(
        align: center,
        ministry,
        upper(organization.full),
        (value: [(#organization.short)], when-present: organization.short),
    )

    per-line(
        align: left,
        (value: [УДК: #udk], when-present: udk),
        (value: [Рег. №: #gos-no], when-present: gos-no),
        (value: [Рег. № ИКРБС: #inventory-no], when-present: inventory-no),
    )

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

    if (approved-by.name, agreed-by.name).any(it => it != none) {
        v(1fr)
    }

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
        if stage != (type: none, num: none) {
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

    v(2fr)

    if performer != none and not force-performers { // TODO: Подписывать как исполнителя
        sign-field(performer.at("name"), performer.at("position"))
    }

    if manager.name != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    v(1fr)
}