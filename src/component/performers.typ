#import "headings.typ": structural-heading-titles
#import "../utils.typ": sign-field

#let validate-performer(performer, index) = {
  // TODO: Добавить поддержку списка
  if type(performer) == array {
    assert(performer.len() in range(2,5), message: "Список исполнителя должен состоять из двух значений: имя исполнителя, его позиция; является ли он соисполнителем")
  } else {
    assert(type(performer) == "dictionary", message: "Тип исполнителя должен быть словарем с полями 'name', 'position' и 'co-performer'")
    assert("name" in performer.keys(), message: "Отсутствует поле 'name' у исполнителя " + repr(index+1))
    assert("position" in performer.keys(), message: "Отсутствует поле 'position' у исполнителя " + repr(index+1))
  }
}

#let fetch-performers(performers) = {
  if type(performers) == "array" {
    for (i, performer) in performers.enumerate() {
      validate-performer(performer, i)
      if type(performer) == "array" {
        performers.at(i) = ("name", "position", "co-performer", "part").zip(performers.at(i)).to-dict()
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
  let contains-co-performers = false;

  for performer in performers {
    if "co-performer" in performer.keys() and performer.co-performer {
      contains-co-performers = true;
      break;
    }    
  }

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