#import "style.typ": small-text

#let fetch-field(field, expected-keys, help-text) = {
  let clean-exptected-keys = expected-keys.map(key => key.replace("*", ""))
  let required-keys = expected-keys.filter(key => key.at(-1) == "*").map(key => key.slice(0, -1))
  let not-required-keys = expected-keys.filter(key => key.at(-1) != "*")

  if type(field) == dictionary {
    for key in required-keys {
      assert(key in field.keys(), message: "В словаре " + help-text + " отсутствует обязательный ключ '" + key + "'")
    }
    for key in field.keys() {
      assert(key in clean-exptected-keys, message: "В словаре " + help-text + " обнаружен неожиданный ключ '" + key + "', допустимые ключи: " + repr(clean-exptected-keys))
    }
    let result = clean-exptected-keys.map(key => (key, none)).to-dict()
    for (key, value) in field {
      result.insert(key, value)
    }
    return result
  }

  else if type(field) == array {
    assert(field.len() >= required-keys.len(), message: "В списке " + help-text + " указаны не все обязательные элементы: " + repr(required-keys))
    assert(field.len() <= expected-keys.len(), message: "В списке " + help-text + " указано слишком много аргументов, требуемые: " + repr(expected-keys))
    let result = (:)
    for (i, key) in expected-keys.enumerate() {
      result.insert(key, field.at(i))
    }
    return result
  }

  else if type(field) == string {
    let result = clean-exptected-keys.map(key => (key, none)).to-dict()
    result.insert(clean-exptected-keys.at(0), field)
    return result
  }

  else if type(field) == none {
    return clean-exptected-keys.map(key => (key, none)).to-dict()
  }

  else {
    panic("Некорректный тип поля " + repr(type(field)) + "(" + repr(field) + ") используйте словарь, список или строку для значения " + help-text)
  }
}

#let unbreak-name(name) = {
    return name.replace(" ", "\u{00A0}")
}

#let sign-field(name, position, part: none, details: "подпись, дата") = {
  if part != none {
    return table(
      inset: (x: 0pt, y: 3pt),
      stroke: none,
      align: bottom,
      columns: (35%, 5%, 1fr, 5%, 20%),
      [#position], [], [], [], [#unbreak-name(name)],
      table.hline(start: 2, end: 3),
      [], [], table.cell(align: center)[#small-text[#details]], [], [(#small-text[#part])]
    )
  } else {
    return table(
      inset: (x: 0pt, y: 3pt),
      stroke: none,
      align: bottom,
      columns: (35%, 5%, 1fr, 5%, 20%),
      [#position], [], [], [], [#unbreak-name(name)],
      table.hline(start: 2, end: 3),
      [], [], table.cell(align: center)[#small-text[#details]], [], [#small-text[#part]]
    )
  }
}