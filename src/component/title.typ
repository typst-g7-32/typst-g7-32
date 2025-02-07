#import "../style.typ": sign-field
#import "../utils.typ": fetch-field, unbreak-name
#import "performers.typ": performers-page
#import "../component/performers.typ": fetch-performers
#import "../title-templates/lib.typ": templates

#let prepare-title-info(document-info) = {
    document-info.organization = fetch-field(document-info.organization, ("full*", "short*"), "организации")
    document-info.agreed-by = fetch-field(document-info.agreed-by, ("name*", "position*", "year"), "утверждения")
    document-info.approved-by = fetch-field(document-info.approved-by, ("name*", "position*", "year"), "согласования")
    document-info.stage = fetch-field(document-info.stage, ("type*", "num"), "этапа")
    document-info.manager = fetch-field(document-info.manager, ("position*", "name*"), "руководителя")

    if document-info.approved-by.year == auto {
        document-info.approved-by.year = document-info.year
    }
    if document-info.agreed-by.year == auto {
        document-info.approved-by.year = document-info.year
    }

    let title-performer = if document-info.performers != none and document-info.performers.len() == 1 {
        document-info.performers.at(0)
    } else {
        none
    }
    let title-info = (:)
    for (key, value) in document-info {
        if key != "performers" {
            title-info.insert(key, value)
        }
    }
    title-info.remove("year")
    title-info.insert("performer", title-performer)
    return title-info
}

#let boilerplate(document-info, title-info) = {
    if title-info.at("performer") != none and document-info.performers.len() > 0 {
        performers-page(document-info.performers)
    }
    context if query(selector(heading)).len() > 0 {
        outline()
    }
}

#let title-with-boilerplate(document-info, template, title-info) = {
    template(..title-info)
    boilerplate(document-info, title-info)
}

#let title(template, body, ..arguments) = context {
    let document-info = query(<document-info>)
    assert(
        document-info.len() != 0,
        message: "В документе отсутствует информация о структуре заголовка, добавьте #show gost.with ..."
    )
    assert(
        document-info.len() == 1,
        message: "В документе не должно быть более одной информации о структуре заголовка, возможно вы несколько раз продублировали команду #show gost.with ..."
    )
    let document-info = document-info.first().value
    document-info.performers = fetch-performers(document-info.performers)

    let title-info = prepare-title-info(document-info)
    
    [#none <gost-template-used>]

    if template == none {
        // TODO: Убрать "Москва {год}" из футера
        boilerplate(document-info, title-info)
    } else {
        title-with-boilerplate(document-info, template, title-info)
    }

    body
}
