#import "../utils.typ": fetch-field

#let align-function = align

#let per-line(align: center, indent: v(1fr), ..values) = {
  let result = ()
  for value in values.pos() {
    let rule = value != none
    if type(value) in (array, dictionary) {
      let data = fetch-field(value, ("value*", "when-present"), default: (when-present: true), hint: "линии")
      if data.when-present != true {
        rule = (data.when-present, ).flatten().all(elem => elem != none)
      }
      value = data.value
    }
    if rule {result.push(value)}
  }
  
  if result != () {
    align-function(align)[
      #grid[#for elem in result {[#elem \ ]}]
    ]
    indent
  }
}

#let if-present(rule: array.all, indent: v(1fr), ..targets) = {
  assert(rule in (array.all, array.any), message: "Правило сравнения указано неверно, должно быть array.all или array.any")
  let check = (target => target != none)
  let result = false
  if rule(targets.pos(), check) {
    body
    indent
  }
}