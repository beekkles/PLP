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
      not-e($Gamma = not not not rho,rho tack tack.t$,
                    notnot-i($Gamma tack not not rho$,
                      ax($Gamma tack rho$)
                    ),
                    ax($Gamma tack not not not rho$),
      )
    )
  )
)]

#line(length: 100%)

== V. Contraposición

#align(center)[
#prooftree(
  impl-i($tack (rho => sigma) => (not sigma => not rho)$,
    impl-i($rho => sigma tack not sigma => not rho$,
      not-i($(rho => sigma), not sigma tack not rho$,
        not-e($Gamma = (rho => sigma), not sigma, rho tack tack.t$,
            impl-e($Gamma tack sigma$,
              ax($Gamma tack rho => sigma$),ax($Gamma tack rho$)
          ),
          ax($Gamma tack not sigma$)
        )
      )
    )
  )
)]



#line(length: 100%)

== VI. Adjunción

Probar $((rho and sigma) => tau) <=> (rho => sigma => tau)$
se reduce a probar

$((rho and sigma) => tau) => (rho => sigma => tau)$
y
$(rho => sigma => tau) => ((rho and sigma) => tau)$

*Caso 1*

#align(center)[
#prooftree(
  impl-i($tack ((rho and sigma) => tau) => (rho => sigma => tau)$,
    impl-i($((rho and sigma) => tau) tack rho => (sigma => tau)$,
      impl-i($((rho and sigma) => tau), rho tack (sigma => tau)$,
        impl-e($Gamma =(rho and sigma) => tau, rho, sigma tack tau$,
          ax($Gamma tack (rho and sigma)=> tau$),
          and-i($Gamma tack (rho and sigma) $,
            ax($Gamma tack rho $),
            ax($Gamma tack sigma $)

          )
        )
      )
    )
)

)]

*Caso 2*

#align(center)[
#prooftree(
  impl-i($tack (rho => sigma => tau) => ((rho and sigma) => tau)$,
    impl-i($(rho => sigma => tau) tack ((rho and sigma) => tau)$,
      impl-e($Gamma = (rho => sigma => tau),(rho and sigma) tack tau$,
        impl-e($Gamma tack sigma => tau $,
          ax($Gamma tack rho => sigma => tau$),
          and-e1($Gamma tack rho$,
            ax($Gamma tack rho and sigma$)
          )
        ),
        and-e2($Gamma tack sigma$,
          ax($Gamma tack rho and sigma$)
        )
      )
    )
)

)]

#line(length: 100%)

== VII. de Morgan (I)
= #text(red)[*Preguntar*]

Queremos probar $not (rho or sigma) <=> (not rho and not sigma)$:

$(==>)$

#align(center)[
#prooftree(
  impl-i($tack not (rho or sigma) => (not rho and not sigma)$,
    and-i($Gamma =not (rho or sigma) tack (not rho and not sigma)$,
      not-i($Gamma tack not rho$,
        not-e($Gamma, rho tack tack.t$,
          ax($Gamma, rho tack rho$),
          or-e($Gamma, rho tack not rho$,
            or-i1($Gamma, rho tack (rho or sigma)$,
              ax($Gamma, rho tack rho$)
            ),
            ax($Gamma, rho tack rho$),
            ax($Gamma, rho, sigma tack rho$)
          )
        )
      ),
      
      not-i($Gamma tack not sigma$,
        not-e($Gamma, sigma tack tack.t$,
        rule($Gamma, sigma tack tau$),
          rule($Gamma, sigma tack not tau$)
        )
        )
      )
    )
)]

$(<==)$


#align(center)[
#prooftree(
  rule($tack (not rho and not sigma) => not (rho or sigma)$)
)]

#line(length: 100%)

== VIII. de Morgan (II)



#line(length: 100%)

== IX. Conmutatividad ($and$)

#align(center)[
  #prooftree(
    impl-i($tack (rho and sigma) => (sigma and rho)$,
      and-i($rho and sigma tack sigma and rho$,
        and-e1($rho and sigma tack rho$,
          ax($rho and sigma tack rho and sigma$)
        ),
        and-e2($rho and sigma tack sigma$,
          ax($rho and sigma tack rho and sigma$)
        )
      )
    )
  )
]

#line(length: 100%)

== X. Asociatividad ($and$)

$((rho and sigma) and tau) <=> (rho and (sigma and tau))$

$(==>)$

#align(center)[
  #prooftree(
    impl-i($tack((rho and sigma) and tau) => (rho and (sigma and tau))$,
      and-i($Gamma = ((rho and sigma) and tau) tack (rho and (sigma and tau))$,
        and-e1($Gamma tack rho$,
          and-e1($Gamma tack rho and sigma$,
            ax($Gamma tack (rho and sigma) and tau$)
          )
        ), 
        and-i($Gamma tack sigma and tau$,
          and-e2($Gamma tack sigma$,
            and-e1($Gamma tack rho and sigma$,
              ax($Gamma tack (rho and sigma) and tau$)
            )
          ),
          and-e2($Gamma tack tau$,
            ax($Gamma tack (rho and sigma) and tau$)
          )
        )
      )
    )
  )
]

$(<==)$

#align(center)[
  #prooftree(
    impl-i($tack (rho and (sigma and tau)) => ((rho and sigma) and tau)$,
      and-i($Gamma = (rho and (sigma and tau)) tack ((rho and sigma) and tau)$,
        and-i($Gamma tack rho and sigma$,
          and-e1($Gamma tack rho$,
            ax($Gamma tack rho and (sigma and tau)$)
          ),
          and-e1($Gamma tack sigma$,
            and-e2($Gamma tack sigma and tau$,
              ax($Gamma tack rho and (sigma and tau)$)
            )
          )
        ), 
        and-e2($Gamma tack tau$,
          and-e2($Gamma tack sigma and tau$,
            ax($Gamma tack rho and (sigma and tau)$)
          ),
        )
      )
    )
  )
]


#line(length: 100%)

== XI. Conmutatividad ($or$)

#align(center)[
  #prooftree(
    impl-i($tack (rho or sigma) => (sigma or rho)$,
      or-e($(rho or sigma) tack sigma or rho$,
          ax($(rho or sigma) tack rho or sigma $),
          or-i2($(rho or sigma), rho tack sigma or rho$,
            ax($(rho or sigma), rho tack rho$)
          ),
          or-i1($(rho or sigma), sigma tack sigma or rho$,
            ax($(rho or sigma), sigma tack sigma$)
          ),
        )
      )
)
]


#line(length: 100%)

== XII. Asociatividad ($or$)

$((rho or sigma) or tau) <=> (rho or (sigma or tau))$

$(==>)$
#align(center)[
  #prooftree(
    impl-i($tack ((rho or sigma) or tau) => (rho or (sigma or tau))$,
      or-e($Gamma = ((rho or sigma) or tau) tack (rho or (sigma or tau))$,
        ax($Gamma tack (rho or sigma) or tau$),
        or-e($Sigma = Gamma, (rho or sigma) tack rho or (sigma or tau)$,
          ax($Sigma tack rho or sigma$),
          or-i1($Sigma,rho tack  rho or (sigma or tau)$,
            ax($Sigma,rho tack rho$)
          ),
          or-i2($Sigma,sigma tack rho or (sigma or tau)$,
            or-i1($Sigma, sigma tack sigma or tau$,
            ax($Sigma, sigma tack sigma$)
            )
          )
        
        ),
        or-i2($Gamma, tau tack rho or (sigma or tau)$,
          or-i2($Gamma, tau tack sigma or tau$,
            ax($Gamma, tau tack tau$)
          )
        )
      )
    )
)]


$(<==)$

#align(center)[
  #prooftree(
    impl-i($tack (rho or (sigma or tau)) => ((rho or sigma) or tau)$,
      or-e($Gamma = (rho or (sigma or tau)) tack ((rho or sigma) or tau)$,
        ax($Gamma tack rho or (sigma or tau)$),
        or-i1($Gamma, rho tack (rho or sigma) or tau$,
          or-i1($Gamma, rho tack rho or sigma$,
            ax($Gamma, rho tack rho$)
          )
        ),
        or-e($Sigma = Gamma, (sigma or tau) tack (rho or sigma) or tau$,
          ax($Sigma tack sigma or tau$),
          or-i1($Sigma, sigma tack (rho or sigma) or tau$,
            or-i2($Sigma, sigma tack rho or sigma$,
              ax($Sigma, sigma tack sigma$)
            )
          ),
          or-i2($Sigma, tau tack (rho or sigma) or tau$,
            ax($Sigma, tau tack tau$)
          )
        )
      )
    ),
)]

#line(length: 100%)
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
                  ax($Gamma, not rho, not tau tack not rho$)
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