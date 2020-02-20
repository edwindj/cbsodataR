describe("query object",{
  
  it("parses a value",{
    x <- eq("NL01", "RegioS")
    expect_equal(as.character(x), "RegioS eq 'NL01'")
  })
  
  it("parses values",{
    x <- eq(c("NL01", "GM0003"), "RegioS")
    expect_equal(as.character(x), "RegioS eq 'NL01' or RegioS eq 'GM0003'")
  })
  
  it("parses has_substring", {
    x <- has_substring("KW", "Perioden")
    expect_equal(as.character(x), "substringof('KW', Perioden)")
  })
  
  it("parses two has_substring", {
    x <- has_substring(c("KW", "JJ"), "Perioden")
    expect_equal(as.character(x), "substringof('KW', Perioden) or substringof('JJ', Perioden)")
  })
  
  it("parses eq | has_substring", {
    x <- eq("2019JJ00", "Perioden") | has_substring("KW", "Perioden")
    expect_equal(as.character(x), "Perioden eq '2019JJ00' or substringof('KW', Perioden)")
  })
})
