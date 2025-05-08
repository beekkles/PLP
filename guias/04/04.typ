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
#let imi = rule.with(name: $->_(i)$)

Comparamos:

#prooftree(
    imi2($Gamma tack lambda x: Bool -> Bool. M:Bool -> Bool -> Bool$,
        $Gamma tack M:Bool <-"INVALIDOOOO"$ 
    )
)

y el original:

#prooftree(
    imi($Gamma tack lambda x: Bool -> Bool. M:Bool -> Bool -> Bool$,
        $Gamma, x:Bool -> Bool tack M:Bool$
    )
)

#pagebreak()

= 9

== a. $sigma -> tau -> sigma$

#prooftree(
    tabs($tack lambda x:sigma. lambda y:tau . x : sigma -> tau -> sigma$,
        tabs($x:sigma tack lambda y:tau . x : tau -> sigma$,
            tvar($x:sigma, y:tau tack x:sigma$)
        )
    )
)

== b. $(sigma -> tau -> rho) -> (sigma -> tau) -> sigma -> rho$


#prooftree(
    tabs($lambda x : sigma -> tau -> rho. lambda y : sigma -> tau. lambda z:sigma. x" "z" "(y " "z) : (sigma -> tau -> rho) -> (sigma -> tau) -> sigma -> rho$,
        tabs($x : sigma -> tau -> rho tack lambda y : sigma -> tau. lambda z:sigma. x" "z" "(y " "z) : (sigma -> tau) -> sigma -> rho$,
            tabs($x : sigma -> tau -> rho,y : sigma -> tau tack lambda z:sigma. x" "z" "(y " "z) : sigma -> rho$,
                tapp($Gamma = {x : sigma -> tau -> rho,y : sigma -> tau, z:sigma} tack (x" "z)" "(y " "z) : rho$,
                    tapp($Gamma tack x" "z: tau -> rho $,
                        tvar($Gamma tack x :sigma -> tau -> rho$),
                        tvar($Gamma tack z : sigma$)
                    ),
                    tapp($Gamma tack y" "z: tau$,
                        tvar($Gamma tack y: sigma -> tau$),
                        tvar($Gamma tack z: sigma$)
                    )
                )
            )
        )
    )
)
== c. $(sigma -> tau -> rho) -> tau -> sigma -> rho$

#prooftree(
    tabs($tack lambda x : sigma -> tau -> rho. lambda y : tau. lambda z: sigma. x" "z" "y: (sigma -> tau -> rho) -> tau -> sigma -> rho$,
        tabs($x : (sigma -> tau -> rho) tack lambda y : tau. lambda z: sigma. x" "z" "y:  tau -> sigma -> rho$,
            tabs($x : (sigma -> tau -> rho), y: tau tack lambda z: sigma. x" "z" "y:  sigma -> rho$,
                tapp($Gamma = {x : (sigma -> tau -> rho), y: tau, z: sigma} tack x" "z" "y:  rho$,
                    tapp($Gamma tack x" "z: tau -> rho$,
                        tvar($Gamma tack x:sigma->tau->rho$),
                        tvar($Gamma tack z: sigma$)
                    ),
                    tvar($Gamma tack  y :tau$)
                )
            )
        )
    )
)


== d. $(tau -> rho) -> (sigma -> tau) -> sigma -> rho$


#prooftree(
    tabs($tack lambda x: tau->rho. lambda y : sigma -> tau. lambda z: sigma. x" "(y" "z):(tau -> rho) -> (sigma -> tau) -> sigma -> rho$,
        tabs($x: tau->rho tack lambda y : sigma -> tau. lambda z: sigma. x" "(y" "z):(sigma -> tau) -> sigma -> rho$,
            tabs($x: (tau->rho), y : (sigma -> tau) tack lambda z: sigma. x" "(y" "z):sigma -> rho$,
                tapp($Gamma = {x: (tau->rho), y : (sigma -> tau), z:sigma} tack x" "(y" "z):rho$,
                    tvar($Gamma tack x: tau -> rho$),
                    tapp($Gamma tack y" "z: tau$,
                        tvar($Gamma tack y: sigma -> tau$),
                        tvar($Gamma z: sigma$)
                    )
                )
            )
        )
    )
)

#pagebreak()

= 10

== a.

#prooftree(
    tiszero($x:sigma tack "isZero(succ"(x)):tau = Bool$,
        tsucc($x:sigma tack "succ"(x) : Nat $,
            tvar($x:sigma tack x: sigma = Nat$)
        )
    )
)

$sigma = Nat, tau = Bool$

== b.

#prooftree(
    tapp($tack (lambda x :sigma .x)(lambda y:Bool."zero"):sigma$,
        tabs($tack (lambda x :sigma .x): sigma -> sigma$,
            tvar($x:sigma tack x:sigma $)
        ),
        tabs($tack (lambda y:Bool."zero"): sigma = Bool -> tau$,
            tzero($y:Bool tack "zero" : tau = Nat$)
        )
    )
)

$sigma = Bool -> Nat$

== c.

$y : tau tack "if" (lambda x : sigma. x) "then" y "else" "succ(zero)" : sigma$

Se nota a simple vista que no tipa, $(lambda x: sigma. x)$ es de $sigma -> sigma$

== d.

#prooftree(
    tapp($x:sigma tack x" "y:tau$,
        tvar($x:sigma tack x: rho -> tau = sigma$),
        rule($x: sigma tack y:rho$)
    )
)

Queda trabado ahí, $y:rho$ no está en el contexto.
== e.

#prooftree(
    tapp($x:sigma, y:tau tack x" "y:tau$,
        tvar($x:sigma, y:tau tack x: tau -> tau = sigma$),
        tvar($x: sigma, y:tau tack y:tau$)
    )
)

$sigma = tau -> tau$

== f.

#prooftree(
    tapp($x: sigma tack x "true" : tau$,
        tvar($x:sigma tack x: Bool -> tau $),
        ttrue($x:sigma tack "true" : Bool $)
    )
)

$sigma = Bool -> tau$

== g.

#prooftree(
    tapp($x: sigma tack x "true" : sigma$,
    rule($x:sigma tack x: Bool -> sigma$),
        ttrue($x:sigma tack "true":Bool$)
    )
)

Pero $sigma != Bool -> sigma$, no tipa.

== h.

#prooftree(
    tapp($x:sigma tack x " " x:tau$,
        rule($x:sigma tack x: rho -> tau$),
        rule($x:sigma tack x: rho$)
    )
)

Pero $tau != rho -> tau$, no tipa.

#pagebreak()

= 13

== a.

$(lambda y: sigma. x" " (lambda x:tau. x))#text(blue)[*{$x:=(lambda y:rho. x" "y)$}*]$

$=_(alpha) (lambda z: sigma. x" " (lambda w:tau. w))#text(blue)[*{$x:=(lambda y:rho. x" "y)$}*]$

$=^"def" (lambda z: sigma. (lambda y:rho. x" "y)" " (lambda w:tau. w))$

== b.

$(y" "(lambda v:sigma." "x" "v))#text(blue)[*{$x:= (lambda y: tau." "v" "y)$}*]$

$=_alpha (y" "(lambda w:sigma." "x" "w))#text(blue)[*{$x:= (lambda z: tau." "v" "z)$}*]$

$=^"def" (y" "(lambda w:sigma." "(lambda z: tau." "v" "z)" "w))$

#pagebreak()

= 15

== a.

$(lambda x:Bool. x) "true" ->_(beta) "true"$

Es valor.

== b.

$lambda x:Bool.2 =^"def" lambda x:Bool. "succ"^2("zero") = lambda x:Bool. "succ(succ(zero))"\
->_"E-Succ" lambda x:Bool. "succ(zero)" ->_"E-Succ" lambda x:Bool. "zero" ->_beta = "zero"
$

Es valor.

== c.

$lambda x:Bool ."pred"(2) = lambda x:Bool ."succ(zero)"\
= lambda x:Bool . V = V
$

== d.

$lambda y: Nat. (lambda x:Bool."pred"(2)) "true" = lambda y: Nat. (lambda x:Bool."pred"("succ(succ(zero))")) "true"\
= lambda y: Nat. (lambda x:Bool."succ(zero)") "true"\
= lambda y: Nat. (lambda x:Bool. V) V ->_(beta) lambda y: Nat. V{x:=V}\
= lambda y: Nat. V = V

$

== e.

$x$ no es un valor

== f.

succ(succ(zero)) = succ(succ(V)) = succ(V) = V

#pagebreak()

= 16

== I.

$(lambda x:Bool. x) "true" ->_beta x{x:="true"} = "true"$ 

Es un programa, forma normal, valor

== II.

$lambda x:Nat."pred(succ("x"))"$

Es un programa, forma normal, valor

== III.

$lambda x:Nat."pred(succ("y"))"$

No es un programa

== IV.

$(lambda x:Bool. "pred(isZero("(x))) "true" ->_beta "pred(isZero("(x))){x:="true"} = "pred(isZero((true)))" $

No es un programa


== V.

$(lambda f:Nat -> Bool. f "zero")" "(lambda x:Nat. "isZero"(x))$

Es un programa, no hay variables libres, el 2do lambda suelta algo de tipo Nat, y la 1era recibe algo de tipo Nat, por lo que tipa

Forma normal, valor

== VI.

$(lambda f: Nat-> Bool. x)" "(lambda x:Nat. "isZero"(x))$

No es un programa

== VII.

$(lambda f :Nat -> Bool. f " " "pred(zero)")" "(lambda x: Nat. "isZero"(x))$

Es un programa, mismo argumento que en el *V*, forma normal, error

== VIII.

$"fix" lambda y:Nat. "succ"(y)$

Es un programa, forma normal, pero nunca termina... ¿runtime error?

#pagebreak()

= 20



#pagebreak()

= 22

#pagebreak()

= 23

#pagebreak()

= 24

#pagebreak()

= 27