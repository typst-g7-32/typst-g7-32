#import "/src/export.typ": custom-title-template
#import custom-title-template: *

#let arguments(..args, year: auto) = {
    let args = args.named()
    args.organization = fetch-field(
        args.at("organization", default: none), 
        default: (
            full: "Московский авиационный институт", 
            short: "Национальный исследовательский университет"), 
        ("*full", "short"), 
        hint: "организации")
    args.agreed-by = fetch-field(args.at("agreed-by", default: none), ("name*", "position*", "year"), hint: "утверждения")
    args.approved-by = fetch-field(args.at("approved-by", default: none), ("name*", "position*", "year"), hint: "согласования")
    args.stage = fetch-field(args.at("stage", default: none), ("type*", "num"), hint: "этапа")
    args.manager = fetch-field(args.at("manager", default: none), ("position*", "name*"), hint: "руководителя")

    if args.approved-by.year == auto {
        args.approved-by.year = year
    }
    if args.agreed-by.year == auto {
        documenargst-arguments.approved-by.year = year
    }
    return args
}

#let template(
    ministry: none,
    organization: (
        full: "Московский авиационный институт", 
        short: "Национальный исследовательский университет"
    ),
    institute: (number: none, name: none),
    department: (number: none, name: none),
    performer: none,
    approved-by: (name: none, position: none, year: auto),
    agreed-by: (name: none, position: none, year: none),
    report-type: "Отчёт",
    about: "О лабораторной работе", 
    part: none,
    bare-subject: false,
    research: none,
    subject: none,
    stage: none,
    manager: (position: none, name: none),
    city: none,
) = {
    per-line(
      indent: none,
      ministry,
      (value: upper(text(size: 18pt)[#organization.full]),
          when-present: organization.full),
      (value: [#upper(organization.short)], 
          when-present: organization.short),
    )

    v(1fr)

    per-line(
        indent: v(2fr),
        force-indent: true,
        align: center,
        (value: [Институт №#institute.number – «#institute.name»],
            when-present: (institute.number, institute.name)),
        (value: [Кафедра #department.number – «#department.name»],       
            when-present: (department.number, department.name)),
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

    if manager.name != none {
        sign-field(manager.at("name"), [Принял:\ #manager.at("position")])
    }

    if performer != none {
        sign-field(performer.at("name", default: none), [Выполнил:\ #performer.at("position", default: none)], part: performer.at("part", default: none))
    }

    v(1fr)
}