posString = "::pos{0,26,-6.9912,3.5826,78.9939}"

r1, r2, r3, r4, r5 = posString:match("([%d//.-]+),([%d//.-]+),([%d//.-]+),([%d//.-]+),([%d//.-]+)")

print(r3)