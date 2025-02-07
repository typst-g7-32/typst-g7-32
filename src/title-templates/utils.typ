#import "../utils.typ": unbreak-name

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