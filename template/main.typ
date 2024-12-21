#import "../properties.typ": *
#import "../utils.typ": *

#set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
)

#set text(
  font: "Times New Roman",
  size: 14pt
)

#set par(
    linebreaks: "optimized",
    first-line-indent: 1.25em,

)
#let small_text(data) = {
    set text(
        font: "Times New Roman",
        size: 12pt
    )
    data
}

#set page(footer: context [
    #let page = here().page()
    #let current_year = datetime.today()
    #align(center)[
        #if page == 1 {"Москва " + current_year.display("[year]")} else {page}
    ]
])

#align(center)[
    Министерство науки и высшего образования Российской Федерации
    Федеральное государственное бюджетное образовательное учреждение \ высшего образования \
    #university
]

#v(25pt)

#grid(
    align(left)[
        УДК: #ydk \
        #for reg in regs {
            reg + "\n"
        }
    ],
) 

#v(15pt)

#align(right)[
    #block(
        width: 250pt,
        table(
            stroke: none,
            align: left,
            inset: (x: 0%),
            columns: (auto, 5fr, 2fr, 1fr, auto, 5fr),
            table.cell(colspan: 6)[УТВЕРЖДАЮ],
            table.cell(colspan: 6)[И. О. проректора университета по научной работе, д р технич. наук, проф.],
            table.cell(colspan: 4)[], table.cell(colspan: 2, align: right)[Ю.А. Равинович],
            table.hline(start: 0, end: 4),
            table.cell(align: right)[«], [], table.cell(align: left)[»], [], [], table.cell(align: right)[2023],
            table.hline(start: 1, end: 2), table.hline(start: 3, end: 5)
        )
    )
]

#v(25pt)


#align(center)[
    ОТЧЕТ \ О НАУЧНО ИСЛЕДОВАТЕЛЬСКОЙ РАБОТЕ \ по теме: \ #theme
]

#v(15%)

#table(
    columns: (2fr, 1fr, 2fr, 1fr),
    [#director.job], [], [], table.cell(align: bottom)[#director.full_name],
    [], [], table.cell(align: center)[#small_text("подпись, дата")], []
)

#pagebreak()
#lorem(100) \
#lorem(100) \
#lorem(100)

#pagebreak()
#lorem(100) \
#lorem(100) \
#lorem(100)

#pagebreak()
#lorem(100) \
#lorem(100) \
#lorem(100)