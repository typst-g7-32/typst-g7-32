#import "style.typ": small-text

#let fetch-field(field, expected-keys, default-values: (:), hint: "") = {
  let expected-keys-arg-error = "Ожидаемые ключи должны быть списком строк, например '(arg1*, arg2), здесь arg1 - обязательный агрумент, а arg2 - необязательный'"

  assert(type(expected-keys) == array, message: expected-keys-arg-error)
  assert(expected-keys.map(elem => type(elem)).all(elem => elem == str), message: expected-keys-arg-error)

  assert(type(default-values) == dictionary, message: "Стандартные значения должны быть определены в словаре, например: 'default-values: (arg1: false)'")
  assert(default-values.len() <= expected-keys.len(), message: "Количество стандартных значений должно быть не больше числа ожидаемых аргументов")

  let get-default(key) = (key, default-values.at(key, default: none))

  get-default("name")

  let clean-expected-keys = expected-keys.map(key => key.replace("*", ""))
  let required-keys = expected-keys.filter(key => key.at(-1) == "*").map(key => key.slice(0, -1))
  let not-required-keys = expected-keys.filter(key => key.at(-1) != "*")

  if type(field) == type(none) {
    return clean-expected-keys.map(get-default).to-dict()
  }

  if type(field) == dictionary {
    for key in required-keys {
      assert(key in field.keys(), message: "В словаре " + hint + " отсутствует обязательный ключ '" + key + "'")
    }
    for key in field.keys() {
      assert(key in clean-expected-keys, message: "В словаре " + hint + " обнаружен неожиданный ключ '" + key + "', допустимые ключи: " + repr(expected-keys))
    }
    let result = clean-expected-keys.map(get-default).to-dict()
    for (key, value) in field {
      result.insert(key, value)
    }
    return result
  }

  else if type(field) == array {
    assert(field.len() >= required-keys.len(), message: "В списке " + hint + " указаны не все обязательные элементы: " + repr(required-keys))
    assert(field.len() <= expected-keys.len(), message: "В списке " + hint + " указано слишком много аргументов, требуемые: " + repr(expected-keys))
    let result = (:)
    for (i, key) in clean-expected-keys.enumerate() {
      result.insert(key, field.at(i, default: get-default(key)))
    }
    return result
  }

  else if type(field) == str {
    let result = clean-expected-keys.map(get-default).to-dict()
    result.insert(clean-expected-keys.at(0), field)
    return result
  }

  else {
    panic("Некорректный тип поля " + repr(type(field)) + "(" + repr(field) + ") используйте словарь, список или строку для значения " + hint)
  }
}

#let unbreak-name(name) = {
    return name.replace(" ", "\u{00A0}")
}

#let sign-field(name, position, part: none, details: "подпись, дата") = {

  // TODO: Оптимизировать
  let part-cell = if part != none { table.cell(align: top)[(#small-text[#part])] } else { [] }

  return table(
    inset: (x: 0pt, y: 3pt),
    stroke: none,
    columns: (45%, 5%, 1fr, 5%, 20%),
    [#position], [], [], [], table.cell(align: bottom)[#unbreak-name(name)],
    table.hline(start: 2, end: 3),
    [], [], table.cell(align: center)[#small-text[#details]], [], part-cell
  )
}
