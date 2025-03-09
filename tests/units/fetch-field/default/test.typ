#import "/src/utils.typ": fetch-field

#let data = (
  a: "test",
)

#let fetched = fetch-field(data, ("a*", "b", "c"), default: (a: 0, b: 0, c: 0))

#assert(fetched == (a: "test", b: 0, c: 0))
