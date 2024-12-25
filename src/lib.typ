#import "component/title.typ": make-title-page
#import "style.typ": gost-style

#let gost = body => {
  let university = "«МОСКОВСКИЙ АВИАЦИОННЫЙ ИНСТИТУТ»\n(национальный исследовательский университет)\n(МАИ)"
  show: gost-style
  make-title-page(director_full_name: "Абрамов А.Б.", director_job: "Руководитель НИР, ассистент кафедры 237", regs: ("НИОКТР: 1234567890", "ИКРБС: 9876543210"), title: "Проверка шаблона", university: university, ydk: "9.32.4")
  outline()
  body
}

#let performer(name, position) = {
  return table(
    stroke: none,
    align: bottom,
    columns: (35%, 5%, 1fr, 4%, 30%),
    [#position], [], [], [], [#name],
    table.hline(start: 2, end: 3),
  )
}