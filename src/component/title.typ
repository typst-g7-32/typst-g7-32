#import "../style.typ": small-text

#let make-title-page(
  ydk: "",
  regs: (),
  university: "",
  title: "",
  director_full_name: "",
  director_job: ""
) = {
  align(center)[
      Министерство науки и высшего образования Российской Федерации
      Федеральное государственное бюджетное образовательное учреждение \ высшего образования \
      #university
  ]

  v(25pt)

  grid(
      align(left)[
          УДК: #ydk \
          #for reg in regs {
              reg + "\n"
          }
      ],
  ) 

  v(15pt)

  align(right)[
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

  v(25pt)


  align(center)[
      ОТЧЕТ \ О НАУЧНО ИСЛЕДОВАТЕЛЬСКОЙ РАБОТЕ \ по теме: \ #title
  ]

  v(20%)

  table(
    stroke: none,
    align: bottom,
    columns: (35%, 5%, 1fr, 5%, 20%),
    [#director_job], [], [], [], [#director_full_name],
    table.hline(start: 2, end: 3),
    [], [], table.cell(align: center)[#small-text[подпись, дата]], [],
  )

  pagebreak()
}