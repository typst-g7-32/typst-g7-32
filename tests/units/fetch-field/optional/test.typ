#import "/src/utils.typ": fetch-field

#let data = (
  a: 1,
  b: 2
)

#let fetched = fetch-field(data, ("a*", "b*", "c"))

#assert(fetched == (a: 1, b: 2, c: none))