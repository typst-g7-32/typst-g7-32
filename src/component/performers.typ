#import "headings.typ": structural-heading-titles
#import "../utils.typ": sign-field

#let validate-performer(performer, index) = {
  // TODO: Добавить поддержку списка
  if type(performer) == array {
    assert(performer.len() == 2 or performer.len() == 3 or performer.len() == 4, message: "Список исполнителя должен состоять  или трех значений: имя исполнителя, его позиция; является ли он соисполнителем")
  } else {
    assert(type(performer) == "dictionary", message: "Тип исполнителя должен быть словарем с полями 'name', 'position' и 'co-performer'")
    assert("name" in performer.keys(), message: "Отсутствует поле 'name' у исполнителя " + repr(index+1))
    assert("position" in performer.keys(), message: "Отсутствует поле 'position' у исполнителя " + repr(index+1))
    assert("co-performer" in performer.keys(), message: "Отсутствует поле 'co-performer' у исполнителя " + repr(index+1))
  }
}

#let fetch-performers(performers) = {
  if type(performers) == "array" {
    for (i, performer) in performers.enumerate() {
      validate-performer(performer, i)
      if type(performer) == "array" {
        if performer.len() == 2 {
          let (name, position) = performers.at(i)
          performers.at(i) = (name: name, position: position)
        } else if performer.len() == 3 {
          let (name, position, co-performer) = performers.at(i)
          performers.at(i) = (name: name, position: position, co-performer: co-performer)
        } else {
          let (name, position, co-performer, part) = performers.at(i)
          performers.at(i) = (name: name, position: position, co-performer: co-performer, part:part)
        }
      }
    }
    return performers
  } else if type(performers) == "dictionary" {
    validate-performer(performers, 0)
    return (performers, )
  }
}

#let performers-page(performers) = {
  heading(structural-heading-titles.performers, outlined: false)
  let co-performers = ()
  for performer in performers {
    if "co-performer" in performer.keys() {
      co-performers.push(performer.co-performer)
    }    
  }

  let contains-co-performers = true in co-performers
  heading(structural-heading-titles.performers, outlined: false)

  for performer in performers {
    if "co-performer" in performer.keys() and performer.co-performer {continue}
    if performer.len() == 2 {
      sign-field(performer.at("name"), performer.at("position"))
    } else if performer.len() == 3 {
      sign-field(performer.at("name"), performer.at("position"))
    } else {
      sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
    }
  }

  if contains-co-performers {
    [Соисполнители:]
    for performer in performers { 
      if not performer.co-performer {continue}
      else if performer.len() == 3 {
        sign-field(performer.at("name"), performer.at("position"))
      } else {
        sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
      }
    }
  }
  pagebreak(weak: true)
}