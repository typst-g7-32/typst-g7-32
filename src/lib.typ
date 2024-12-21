#import "component/title.typ": make-title-page
#import "style.typ": default

#let gost = body => {
  let university = "«МОСКОВСКИЙ АВИАЦИОННЫЙ ИНСТИТУТ»\n(национальный исследовательский университет)\n(МАИ)"
  show: default
  make-title-page(director_full_name: "Абрамов А.Б.", director_job: "Руководитель НИР, ассистент кафедры 237", regs: ("НИОКТР: 1234567890", "ИКРБС: 9876543210"), title: "Проверка шаблона", university: university, ydk: "9.32.4")
  outline()
  body
}