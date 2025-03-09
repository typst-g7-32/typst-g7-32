#import "../utils.typ": fetch-field
#import "../component/title.typ": detailed-sign-field

#let align-function = align

#let per-line(align: center, indent: v(1fr), ..values) = {
  let result = ()
  for value in values.pos() {
    let rule = false
    if type(value) in (array, dictionary) {
      let data = fetch-field(value, ("value*", "when-rule", "when-present"), default: (when-present: "any", when-rule: none), hint: "линии")
      assert(not (data.when-rule != none and data.when-present != "any"), message: "Должно быть выбрано только одно правило пояивления when-rule или when-present")
      if data.when-rule != none {
        rule = data.when-rule
      }
      if data.when-present != "any" {
        rule = (data.when-present, ).flatten().all(elem => elem != none)
      }
      value = data.value
    } else {
      rule = value != none
    }
    if rule {
      result.push(value)
    }
  }
  
  if result != () {
    align-function(align)[
      #grid[#for elem in result {[#elem \ ]}]
    ]
    indent
  }
}

#let if-present(rule: array.all, indent: v(1fr), ..targets, body) = {
  assert(rule in (array.all, array.any), message: "Правило сравнения указано неверно, должно быть array.all или array.any")
  let check = (target => target != none)
  if rule(targets.pos(), check) {
    body
    indent
  }
}

#let approved-field(approved-by) = {
  if approved-by.name != none [
    #detailed-sign-field("согласовано", approved-by.name, approved-by.position, approved-by.year)
  ]
}

#let agreed-field(agreed-by) = {
  if agreed-by.name != none [
    #detailed-sign-field("утверждаю", agreed-by.name, agreed-by.position, agreed-by.year)
  ]
}

#let approved-and-agreed-fields(approved-by, agreed-by) = {
  if-present(rule: array.any, approved-by.name, agreed-by.name)[
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      gutter: 20%,
      approved-field(approved-by),
      agreed-field(agreed-by)
    )
  ]
}