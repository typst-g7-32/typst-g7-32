#let page_number() = {
  context {
    let page = here().page()
    let current_year = datetime.today()
    if page == 1 {"Москва " + current_year.display("[year]")} else {page}
  }
}