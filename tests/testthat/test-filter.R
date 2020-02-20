describe("get_filter works",{
  it("parses a value",{
    x <- get_filter(RegioS = "NL01")
    expect_equal(x, "(RegioS eq 'NL01')")
  })
  
  it("parses values",{
    x <- get_filter(RegioS = c("NL01  ", "GM0003"))
    expect_equal(x, "(RegioS eq 'NL01  ' or RegioS eq 'GM0003')")
  })
  
  it("parses has_substring",{
    x <- get_filter(Perioden = has_substring("KW"))
    expect_equal(x, "(substringof('KW', Perioden))")
  })
  
  it("parses has_substring with multiple substrings",{
    x <- get_filter(Perioden = has_substring(c("KW", "JJ")))
    expect_equal(x, "(substringof('KW', Perioden) or substringof('JJ', Perioden))")
  })

  it("parses has_substring and eq",{
    x <- get_filter(Perioden = has_substring("KW") | eq("2019JJ00"))
    expect_equal(x, "(substringof('KW', Perioden) or Perioden eq '2019JJ00')")
  })
  
  it("parses multiple columns",{
    x <- get_filter(Perioden = has_substring("KW"), RegioS = c("NL01  ", "GM0003"))
    expect_equal(x, "(substringof('KW', Perioden)) and (RegioS eq 'NL01  ' or RegioS eq 'GM0003')")
  })
  
})