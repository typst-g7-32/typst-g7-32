#import "headings.typ": structural-heading-titles
#import "../utils.typ": sign-field

#let validate-performer(performer, index) = {
  // TODO: Добавить поддержку списка
  if type(performer) == array {
    assert(performer.len() in range(2,5), message: "Список исполнителя должен состоять из двух значений: имя исполнителя, его позиция; является ли он соисполнителем")
  } else if type(performer) == str {} else {
    assert(type(performer) == dictionary, message: "Тип исполнителя должен быть словарем с полями 'name', 'position' и 'co-performer'")
    assert("name" in performer.keys(), message: "Отсутствует поле 'name' у исполнителя " + repr(index+1))
    assert("position" in performer.keys(), message: "Отсутствует поле 'position' у исполнителя " + repr(index+1))
  }
}

#let fetch-performers(performers) = {
  let current-organization = "";
  if type(performers) == array {
    for (i, performer) in performers.enumerate() {
      validate-performer(performer, i)
      if type(performer) == array {
        performers.at(i) = ("name", "position", "co-performer", "part").zip(performers.at(i)).to-dict()
        performers.at(i).insert("organization", current-organization)
      } else if type(performer) == str {
        current-organization = performer
      } else {
        performers.at(i).insert("organization", current-organization)
      }
    }
    return performers
  } else if type(performers) == dictionary {
    validate-performer(performers, 0)
    return (performers, )
  }
}

#let performers-page(performers) = {
  heading(structural-heading-titles.performers, outlined: false)
  let co-performers = ()
  let organizations = ("",)
  let contains-co-performers = false

  for performer in performers {
    if type(performer) != str {
      if "co-performer" in performer.keys() and performer.co-performer {
        contains-co-performers = true
      }
    } else {
      if performer not in organizations {
        organizations.push(performer)
      }
    }   
  }

  for performer in performers {
    if type(performer) != str and performer.organization == "" {
      if "co-performer" in performer.keys() and performer.co-performer {continue}
      if performer.len() == 3 {
        sign-field(performer.at("name"), performer.at("position"))
      } else if performer.len() == 4 {
        sign-field(performer.at("name"), performer.at("position"))
      } else {
        sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
      }
    }
  }

  let organization-is-present

  for organization in organizations {
    organization-is-present = false
    for performer in performers {
      if type(performer) == str {continue}
      if "co-performer" not in performer.keys() or not performer.co-performer {
        if performer.organization == organization {
          organization-is-present = true
          break
        }
      }
    }
    if organization-is-present {
      set par(spacing: 0.5em)
      if organization != "" {
        block[#organization:]
      }
      for performer in performers {
        if type(performer) == str {continue}
        if "co-performer" in performer.keys() and performer.co-performer {continue}
        if performer.organization != organization {continue}
        if performer.organization == "" {continue}
        if performer.len() == 3 {
          sign-field(performer.at("name"), performer.at("position"))
        } else if performer.len() == 4 {
          sign-field(performer.at("name"), performer.at("position"))
        } else {
          sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
        }
      }
    }
  }

  if contains-co-performers {
    block[Соисполнители:]
    for performer in performers { 
      if type(performer) != str {
        if "co-performer" not in performer.keys() or not performer.co-performer {continue}
        if performer.organization != "" {continue}
        if performer.len() == 4 {
          sign-field(performer.at("name"), performer.at("position"))
        } else {
          sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
        }
      }
    }
    for organization in organizations {
      organization-is-present = false
      for performer in performers {
        if type(performer) == str {continue}
        if "co-performer" in performer.keys() and performer.co-performer {
          if performer.organization == organization {
            organization-is-present = true
            break
          }
        }
      }
      if organization-is-present {
        set par(spacing: 0.5em)
        if organization != "" {
          block[#organization:]
        }
        for performer in performers {
          if type(performer) == str {continue}
          if "co-performer" not in performer.keys() or not performer.co-performer {continue}
          if performer.organization != organization {continue}
          if performer.organization == "" {continue}
          if performer.len() == 4 {
            sign-field(performer.at("name"), performer.at("position"))
          } else {
            sign-field(performer.at("name"), performer.at("position"), part: performer.at("part"))
          }
        }
      }
    }
  }
  pagebreak(weak: true)
}