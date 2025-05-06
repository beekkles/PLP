#import "@preview/arborly:0.3.0": tree
#import "@preview/curryst:0.5.1": rule, prooftree

#set page(columns: 2, height: 19cm)

= 1

== a.

$x <- $ válido, término

== b.

$x" "x <-$ válido, término

== c.

$M <-$ inválido

== d.

$M " " M <-$ inválido

== e.

true false $<-$ válido, término

== f.

true succ(false true) $<-$ válido, término

== g.

$lambda x .$isZero($x$) $<-$ inválido

== h.

$lambda x: sigma."succ"(x)$ $<-$ inválido

== i.

$lambda x : "Bool. succ"(x)$ $<-$ válido, término

== j.

$lambda x : "if true then Bool else Nat."x$ $<-$ inválido

== k.

$sigma$ $<-$ inválido

== l.

Bool $<-$ válido, tipo

== m.

Bool $->$ Bool $<-$ válido, tipo

== n.

Bool $->$ Bool $->$ Nat $<-$ válido, tipo

== ñ.

(Bool $->$ Bool) $->$ Nat $<-$ válido, tipo

== o.

succ true $<-$ inválido

== p.

$λ x :$ Bool. if zero then true else zero succ(true) $<-$ válido, término

#pagebreak()
#set page(columns: 1, height: auto)


= 3

== a.

Marcar las ocurrencias del término $x$ como subtérmino en $λ x$ : Nat. succ(($λ x$ : Nat. $x$) $x$).

Podemos plantear una $alpha$ equivalencia tal que:

$λ x$ : Nat. succ(($λ x$ : Nat. $x$) $x$) $=_alpha$ $λ z$ : Nat. succ(($λ y$ : Nat. $y$) $z$)

Por lo que hay 0 ocurrencias.
== b.

¿Ocurre $x_1$ como subtérmino en $λ x_1$ : Nat. succ($x_2$)?

No

== c.

¿Ocurre $x$ ($y$ $z$) como subtérmino en $u$ $x$ ($y$ $z$)?

$u$ $x$ ($y$ $z$) = ($u$ $x$) ($y$ $z$), entonces no.


= 4 

== a.

$u$ $x$ ($y$ $z$) (λ$v$ : Bool. $v$ $y$) 

$=$ ((($u$ $x$) ($y$ $z$)) (λ$v$ : Bool. ($v$ $y$)))

*Árbol*
$
#tree[((($u$ $x$) ($y$ $z$)) (λ$v$ : Bool. ($v$ $y$)))
  [
    (($u$ $x$) ($y$ $z$))
    [
    ($u$ $x$) [$u$][$x$]
    ]
    [
    ($y$ $z$) [$y$][$z$]
    ]
  ]
  [
    (λ#text(red)[$v$] : Bool. (#text(red)[$v$] $y$)) [($v$ $y$) [$v$][$y$]]
  ]
]
$

== b.

($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. $x$ $z$ ($y$ $z$)) $u$ $v$ $w$

$=$  (((($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$))) $u$) $v$) $w$)

*Árbol*

#tree[(((($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$))) $u$) $v$) $w$)
    [((($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$))) $u$) $v$)
        [(($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$))) $u$)
            [($λ #text(red)[x]$ : Bool → Nat → Bool. $λ #text(red)[y]$ : Bool → Nat. $λ #text(red)[z]$ : Bool. ((#text(red)[$x$ $z$]) (#text(red)[$y$ $z$])))
                [($λ #text(red)[x]$ : Bool → Nat → Bool. $λ #text(red)[y]$ : Bool → Nat.((#text(red)[$x$] $z$) (#text(red)[$y$] $z$)))
                    [($λ #text(red)[x]$ : Bool → Nat → Bool. ((#text(red)[$x$] $z$) ($y$ $z$)))
                        [(($x$ $z$) ($y$ $z$))
                            [($x$ $z$)[$x$][$z$]][($y$ $z$)[$y$][$z$]]
                        ] 
                    ]
                ]
            ][$u$]
        ]
    ]
    [$w$]
]

== c.

$w$ ($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. $x$ $z$ ($y$ $z$)) $u$ $v$

$=$ ((($w$ ($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$)))) $u$) $v$)

*Árbol*

#tree[((($w$ ($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$)))) $u$) $v$)
    [(($w$ ($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$)))) $u$)
        [($w$ ($λ x$ : Bool → Nat → Bool. $λ y$ : Bool → Nat. $λ z$ : Bool. (($x$ $z$) ($y$ $z$))))
            [$w$][($λ #text(red)[x]$ : Bool → Nat → Bool. $λ #text(red)[y]$ : Bool → Nat. $λ #text(red)[z]$ : Bool. ((#text(red)[$x$] #text(red)[$z$]) (#text(red)[$y$] #text(red)[$z$])))
                [($λ #text(red)[x]$ : Bool → Nat → Bool. $λ #text(red)[y]$ : Bool → Nat. ((#text(red)[$x$] $z$) (#text(red)[$y$] $z$)))
                    [($λ #text(red)[x]$ : Bool → Nat → Bool. ((#text(red)[$x$] $z$) ($y$ $z$)))
                        [(($x$ $z$) ($y$ $z$))[($x$ $z$)[$x$][$z$]][($y$ $z$)[$y$][$z$]]]
                    ]
                ]
            ]
        ][$u$]
    ]
    [$v$]
]


*LAS VARIABLES ROJAS SON LIGADAS*

*El término buscado aparece en el punto (b) al tercer nivel*

#pagebreak()

#let ttrue = rule.with(name: [T-True])
#let tfalse = rule.with(name: [T-False])
#let tvar = rule.with(name: [T-Var])
#let tif = rule.with(name: [T-If])
#let tabs = rule.with(name: [T-Abs])
#let tapp = rule.with(name: [T-App])
#let tzero = rule.with(name: [T-Zero])
#let tsucc = rule.with(name: [T-Succ])
#let tpred = rule.with(name: [T-Pred])
#let tiszero = rule.with(name: [T-IsZero])
#let tfix = rule.with(name: [T-Fix])

#let Nat = [Nat]
#let Bool = [Bool]

= 6

== a.

#prooftree(
    tif($tack "if true then zero else succ(zero)":Nat$,
        ttrue($tack "true":Bool$),
        tzero($tack "zero" : Nat$),
        tsucc($tack "succ(zero)":Nat$,
            tzero($tack "zero":Nat$)
        )
    )
)

== b.

#prooftree(
    tif($Gamma = x: Nat, y: Bool tack "if true then false else " (lambda z:Bool. z) "true" : Bool $,
        ttrue($Gamma tack "true":Bool$),
        tfalse($Gamma tack "false":Bool$),
        tapp($Gamma tack (lambda z:Bool. z) "true" :Bool$,
            tabs($Gamma tack (lambda z:Bool. z):Bool -> Bool$,
                tvar($Gamma,z:Bool tack z : Bool$),
            ),
            ttrue($Gamma tack "true":Bool$)
        )
    )
)

== c.

#prooftree(
    tif($tack "if " lambda x: Bool. x "then zero else succ(zero)":Nat$,
        rule($ tack (lambda x: Bool. x):Bool$,
            text(red)[*INVALIDO*]
        ),
        tzero($tack "zero":Nat$),
        tsucc($tack "succ(zero)":Nat$,
            tzero($tack "zero":Nat$)
        )
    )
)

*Es inválido porque*
$(lambda x: Bool. x)$ es $Bool -> Bool$


== d.

#prooftree(
    tapp($Gamma = x:Bool->Nat,y:Bool tack (x " " y) : Nat$,
        tvar($Gamma tack x:Bool -> Nat$),
        tvar($Gamma tack y:Bool$)
    )
)

#pagebreak()

= 7

#let imi2 = rule.with(name: $->_(i 2)$)

#prooftree(
    imi2($$)
)