#import "../component/title.typ": detailed-sign-field
#import "../utils.typ": sign-field
#import "utils.typ": per-line, approved-and-agreed-fields

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
        ministry,
        (value: upper(organization.full), when-present: organization.full),
        (value: [(#organization.short)], when-present: organization.short),
    )

    per-line(
        align: left,
        (value: [УДК: #udk], when-present: udk),
        (value: [Рег. №: #gos-no], when-present: gos-no),
        (value: [Рег. № ИКРБС: #inventory-no], when-present: inventory-no),
    )
    
    approved-and-agreed-fields(approved-by, agreed-by)

    per-line(
        align: center,
        indent: v(2fr),
        (value: upper(report-type), when-present: report-type),
        (value: upper(about), when-present: about),
        (value: research, when-present: research),
        (value: [по теме:], when-rule: not bare-subject),
        (value: upper(subject), when-present: subject),
        (
            value: [(#stage.type)],
            when-rule: (stage.type != none and stage.num == none)),
        (
            value: [(#stage.type, этап #stage.num)], 
            when-present: (stage.type, stage.num)
        ),
        (value: [\ Книга #part], when-present: part),
    )

    // TODO: Подписывать как исполнителя
    if performer != none and not force-performers {
        // TODO: Использовать fetch-fields
        sign-field(performer.at("name", default: none), performer.at("position", default: none), part: performer.at("part", default: none))
    }

    if manager.name != none {
        sign-field(manager.at("name"), manager.at("position"))
    }

    v(1fr)
}