#import "headings.typ": structural-headings
#import "../utils.typ": sign-field

#let validate-performer(performer, index) = {
  // TODO: Добавить поддержку списка
  if type(performer) == array {
    assert(performer.len() == 2, message: "Список исполнителя должен состоять из двух значений: имя исполнителя и его позиция")
  } else {
    assert(type(performer) == "dictionary", message: "Тип исполнителя должен быть словарем с полями 'name' и 'position'")
    assert("name" in performer.keys(), message: "Отсутствует поле 'name' у исполнителя " + repr(index+1))
    assert("position" in performer.keys(), message: "Отсутствует поле 'position' у исполнителя " + repr(index+1))
  }
}

#let fetch-performers(performers) = {
  if type(performers) == "array" {
    for (i, performer) in performers.enumerate() {
      validate-performer(performer, i)
      if type(performer) == "array" {
        let (name, position) = performers.at(i)
        performers.at(i) = (name: name, position: position)
      }
    }
    return performers
  } else if type(performers) == "dictionary" {
    validate-performer(performers, 0)
    return (performers, )
  }
}

#let performers-page(performers) = {
  structural-headings.performers
  for performer in performers {
    sign-field(performer.at("name"), performer.at("position"))
  }
  pagebreak(weak: true)
}