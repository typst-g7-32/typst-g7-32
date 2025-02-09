#import "../utils.typ": fetch-field, unbreak-name
#import "performers.typ": performers-page
#import "../component/performers.typ": fetch-performers

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

#let prepare-title-info(document-arguments) = {
    document-arguments.organization = fetch-field(document-arguments.organization, ("full*", "short*"), "организации")
    document-arguments.agreed-by = fetch-field(document-arguments.agreed-by, ("name*", "position*", "year"), "утверждения")
    document-arguments.approved-by = fetch-field(document-arguments.approved-by, ("name*", "position*", "year"), "согласования")
    document-arguments.stage = fetch-field(document-arguments.stage, ("type*", "num"), "этапа")
    document-arguments.manager = fetch-field(document-arguments.manager, ("position*", "name*"), "руководителя")

    if document-arguments.approved-by.year == auto {
        document-arguments.approved-by.year = document-arguments.year
    }
    if document-arguments.agreed-by.year == auto {
        document-arguments.approved-by.year = document-arguments.year
    }

    let title-performer = if document-arguments.performers != none and document-arguments.performers.len() == 1 {
        document-arguments.performers.at(0)
    } else {
        none
    }
    let title-arguments = (:)
    for (key, value) in document-arguments {
        if key != "performers" {
            title-arguments.insert(key, value)
        }
    }
    title-arguments.remove("year")
    title-arguments.insert("performer", title-performer)
    return title-arguments
}

#let title(template, ..arguments) = context {
    let arguments = arguments.named()
    let title-arguments = prepare-title-info(arguments)

    template(..title-arguments)
}