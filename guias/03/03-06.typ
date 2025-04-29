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

#let pbc = rule.with(name: [PBC])
#let lem = rule.with(name: [LEM])


= Ejercicio 6

Demostrar en deducción natural que vale $tack sigma$ para cada una de las siguientes fórmulas. Para estas fórmulas es
imprescindible usar lógica clásica:
#line(length: 100%)

== I. Absurdo clásico


#align(center)[
  #prooftree(
    impl-i($tack (not tau => tack.t) => tau$,
      pbc($not tau => tack.t tack tau$,
        impl-e($Gamma = {not tau => tack.t, not tau} tack tack.t$,
          ax($Gamma tack not tau => tack.t$),
          ax($Gamma tack not tau$, 
          )
        )
      )
)
  )
]

#line(length: 100%)


== II. Ley de Peirce

#align(center)[
  #prooftree(
    impl-i($tack ((tau => rho) => tau) => tau$,
      pbc($Gamma = ((tau => rho) => tau) tack tau$,
          not-e($Gamma, not tau tack tack.t$,
            impl-e($Gamma, not tau tack tau$,
              ax($Gamma, not tau tack (tau => rho) => tau$),
              impl-i($Gamma, not tau tack (tau => rho) $,
                tack-e($Gamma, not tau, tau tack rho $,
                  not-e($Gamma, not tau, tau tack tack.t$,
                    ax($Gamma, not tau, tau tack tau$),
                    ax($Gamma, not tau, tau tack not tau$)
                  )
                )
              )
            ),
            ax($Gamma, not tau tack not tau$)
          )
      )
    )
)]

#line(length: 100%)

== III. Tercero excluido
Esto se puede probar con PBC pero ya tenemos dado LEM.

#align(center)[
  #prooftree(
    lem($tack tau or not tau$)
  )]  
#line(length: 100%)

== IV. Consecuencia milagrosa

#align(center)[
  #prooftree(
    impl-i($tack (not tau => tau) => tau$,
      pbc($(not tau => tau) tack tau$,
        not-e($Gamma ={(not tau => tau), not tau} tack tack.t$,
          impl-e($Gamma tack tau$,
            ax($Gamma tack not tau => tau$),
            ax($Gamma tack not tau$)
          ),
          ax($Gamma tack not tau$)
        )
      )
    )
  )]

#line(length: 100%)

== V. Contraposición clásica

#align(center)[
  #prooftree(
    impl-i($tack (not rho => not tau) => (tau => rho)$,
      impl-i($(not rho => not tau) tack (tau => rho)$,
        pbc($(not rho => not tau), tau tack rho$,
          not-e($Gamma = {(not rho => not tau), tau, not rho} tack tack.t $,
            ax($Gamma tack tau$),
            impl-e($Gamma tack not tau$,
              ax($Gamma tack not rho => not tau$),
              ax($Gamma tack not rho$)
            )
          )
        )
      )

)
  )]  

#line(length: 100%)
== VI. Análisis de casos 

No compila completo, habría que cambiar #text(red)[#link("https://github.com/typst/typst/blob/b8034a343831e8609aec2ec81eb7eeda57aa5d81/crates/typst-pdf/src/lib.rs#L594")[*esta línea*]]


#align(center)[
  #prooftree(
    impl-i($tack (tau => rho) => ((not tau => rho) => rho)$,
      impl-i($(tau => rho) tack (not tau => rho) => rho$,
        pbc($Gamma = {(tau => rho), (not tau => rho)} tack rho$,
          not-e($Gamma, not rho tack tack.t$,
            impl-e($Gamma, not rho tack rho$,
              ax($Gamma, not rho tack tau => rho$),
              pbc($Gamma, not rho tack tau $,
                not-e($Gamma, not rho, not tau tack tack.t$,
                  impl-e($Gamma, not rho, not tau tack rho$,
                    ax($Gamma, not rho, not tau tack not tau => rho$),
                    ax($Gamma, not rho, not tau tack not tau$)
                  ),
                )
              )
            ),
            ax($Gamma, not rho tack not rho$)
          )
        )
      )
    )
  )
]


#line(length: 100%)

== VII. Implicación vs disyunción

$(tau => rho) <=> (not tau or rho)$

$(==>)$

#align(center)[
  #prooftree(
    impl-i($tack (tau => rho) => (not tau or rho)$,
      pbc($(tau => rho) tack (not tau or rho)$,
        not-e($(tau => rho), not (not tau or rho) tack tack.t $,
          rule($(tau => rho), not (not tau or rho) tack $),
          rule($(tau => rho), not (not tau or rho) tack $)
        )
      )  
    )
  )
]

$(<==)$

#align(center)[
  #prooftree(
    rule($(not tau or rho) => (tau => rho)$)
  )
]