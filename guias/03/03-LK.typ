#import "@preview/curryst:0.5.1": rule, prooftree

#let ax = rule.with(name: [ax])

// intuicionista
#let and-e1 = rule.with(name: $and_e_1$)
#let and-e2 = rule.with(name: $and_e_2$)
#let and-i = rule.with(name: $and_i$)


#let impl-i = rule.with(name: $scripts(=>)_i$)
#let impl-e = rule.with(name: $scripts(=>)_e$)

#let or-i1 = rule.with(name: $or_i_1$)
#let or-i2 = rule.with(name: $or_i_2$)
#let or-e  = rule.with(name: $or_e$)

#let not-i = rule.with(name: $not_i$)
#let not-e = rule.with(name: $not_e$)

#let tack-e  = rule.with(name: $tack.t_e$)

#let w = rule.with(name: [W])

#let notnot-i = rule.with(name: $not not _i$)

#let mt = rule.with(name: [MT])
// clásica
#let notnot-e = rule.with(name: $not not _e$)


