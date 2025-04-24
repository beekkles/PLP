#import "@preview/curryst:0.5.1": rule, prooftree

#let ax = rule.with(name: [ax])

// intuicionista
#let and-e1 = rule.with(name: $and_e_1$)
#let and-e2 = rule.with(name: $and_e_2$)

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

= Ejercicio 5
Demostrar en deducción natural que las siguientes fórmulas son teoremas sin usar principios de razonamiento clásicos salvo que se indique lo contrario. Recordemos que una fórmula $sigma$ es un teorema si y sólo si vale $tack sigma$:

#line(length: 100%)


== I. _Modus ponens_ relativizado:

#align(center)[
#prooftree( 
  impl-i( 
    $tack (rho => (sigma => tau)) => ((rho => sigma) => (rho => tau))$,
      impl-i($(rho => (sigma => tau)) tack ((rho => sigma) => (rho => tau))$,
        impl-i($(rho => (sigma => tau)), (rho => sigma) tack (rho => tau)$,
          impl-e($ Gamma = rho => (sigma => tau), rho => sigma, rho tack tau $,
              impl-e($Gamma tack sigma => tau$,
                ax($Gamma, rho tack rho => sigma => tau$),
                ax($Gamma, sigma => tau tack rho$)
              ), 
              impl-e($Gamma tack sigma$,
                ax($Gamma tack rho => sigma$),
                ax($Gamma, sigma tack rho$)
              )
          ),
        ),
      ), 
  )
)
]

#line(length: 100%)

== II. Reducción al absurdo

#align(center)[
#prooftree(

  impl-i($tack (rho => tack.t) => not rho$,
    not-i($(rho => tack.t) tack not rho$,
        impl-e($Gamma =(rho => tack.t), rho tack tack.t$,
          ax($Gamma tack rho => tack.t$),
          ax($Gamma tack rho$)
        ),
      )
  )
)]

#line(length: 100%)

== III. Introducción de la doble negación

#align(center)[
#prooftree(
  impl-i($tack rho => not not rho$,
      not-i($rho tack not not rho$,
        not-e($rho, not rho tack tack.t$,
          ax($rho, not rho tack rho$),
          ax($rho, not rho tack not rho$)
        )
      )
    )
)]

#line(length: 100%)

== IV. Eliminación de la triple negación

#align(center)[
#prooftree(
  impl-i($tack not not not rho => not rho$,
    not-i($not not not rho tack not rho$,
      not-e($Gamma = not not not rho, not not rho tack tack.t$,
        rule($Gamma tack not not rho$),
        rule($Gamma tack not not not rho$)
      )
    )
  )
)]

#line(length: 100%)

== V. Contraposición


#line(length: 100%)

== VI. Adjunción


#line(length: 100%)

== VII. de Morgan (I)


#line(length: 100%)

== VIII. de Morgan (II)


#line(length: 100%)

== IX. Conmutatividad ($and$)


#line(length: 100%)

== X. Asociatividad ($and$)


#line(length: 100%)

== XI. Conmutatividad ($or$)


#line(length: 100%)

== XII. Asociatividad ($or$)