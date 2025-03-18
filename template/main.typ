#import "@preview/modern-g7-32:0.1.0": gost, abstract

#show: gost.with(
  ministry: "Наименование министерства (ведомства) или другого структурного образования, в систему которого входит организация-исполнитель",
  organization: (
    full: "Полное наименование организации — исполнителя НИР", 
    short: "Сокращённое наименование организации"),
  udk: "индекс УДК",
  research-number: "регистрационный номер НИР",
  report-number: "регистрационный номер отчета",
  approved-by: (
    name: "Фамилия И.О.", 
    position: "Должность, сокращ. наимен. орг"
  ),
  agreed-by: (
    name: "Фамилия И.О.", 
    position: "Должность, сокращ. наимен. орг"
  ),
  report-type: "отчёт",
  about: "О научно-исследовательской работе",
  subject: "Наименование отчёта",
  manager: (name: "Фамилия И.О.", position: "Должность"),
  city: "Город",
  performers: (
    (name: "И.О. Фамилия", position: "Должность"),
    (name: "И.О. Фамилия", position: "Должность")
  ),
)

#abstract("шаблон", "гост", "typst", "демонстрация", "ключевые слова")[
Некоторый текст, относящийся к реферату
]

#outline()

= Введение
Некоторый текст, относящийся к введению
= Раздел
== Подраздел
=== Пункт
= Заключение
Некоторый текст, относящийся к заключению
