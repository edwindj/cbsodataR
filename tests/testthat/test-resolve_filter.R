describe("resolve_filter works",{
  it("parses a simple filter statement",{
    f <- resolve_filter("Periods eq '2001JJ00'")
    expect_equal(f, list(Periods = "2001JJ00"))
  })
  
  it("parses a two values",{
    f <- resolve_filter("((Periods eq '2001JJ00') or (Periods eq '2002JJ00'))")
    expect_equal(f, list(Periods = c("2001JJ00","2002JJ00")))
  f})
  
  it("parses a two values and a different column",{
    f <- resolve_filter("(Periods eq '2001JJ00' or Periods eq '2002JJ00') and (RegioS eq 'GM0003')")
    expect_equal(f, list( Periods = c("2001JJ00","2002JJ00")
                        , RegioS = "GM0003"
                        )
                 )
  })
  
  it("parses a substringof",{
    f <- resolve_filter("substringof('KW', Periods)")
    expect_equal(f, list(Periods = quote(has_substring("KW"))))
  })
  
  it("parses a substringof and another thingy",{
    f <- resolve_filter("(substringof('KW', Periods)) and RegioS eq 'GM0003'")
    expect_equal(f, list(Periods = quote(has_substring("KW")), RegioS = "GM0003"))
  })
  
  it("parses a substringof or-ed with a value",{
    f <- resolve_filter("substringof('KW', Periods) or Periods eq '2011JJ00'")
    expect_equal(f, list(Periods = quote(eq("2011JJ00") | has_substring("KW"))))
  })
})

describe("Eat your own dog food",{
  eyodf <- function(l){
    x <- do.call(get_filter, l)
    resolve_filter(x, quoted = FALSE)
  }
  
  l <- list(Perioden = "2019JJ00")
  f <- eyodf(l)
  expect_equal(f, l)

  l <- list(Perioden = c("2019JJ00", "2020JJ00"))
  f <- eyodf(l)
  expect_equal(f, l)
  
  l <- list(Perioden = has_substring("JJ"))
  f <- eyodf(l)
  expect_equal(f, l)
  
  l <- list(Perioden = has_substring(c("JJ", "KW")))
  f <- eyodf(l)
  expect_equal(f, l)
  
  l <- list(Perioden = eq("2019KW04") | has_substring("JJ"))
  f <- eyodf(l)
  expect_equal(f, l)
  
})
