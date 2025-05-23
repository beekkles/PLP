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

$lambda x:Bool.2 =^"def" lambda x:Bool. "succ"^2("zero") = lambda x:Bool. "succ(succ(zero))" ->_beta "succ(succ(zero))"$

Es valor.

== c.

$lambda x:Bool ."pred"(2) = lambda x:Bool ."pred(succ(succ(zero)))"\
->_"E-PredSucc" lambda x:Bool. "succ(zero)" ->_beta "succ(zero)"
$

Es valor

== d.

$lambda y: Nat. (lambda x:Bool."pred"(2)) "true"\
= lambda y: Nat. (lambda x:Bool."pred"("succ(succ(zero))")) "true"\
->_"E-Pred_Succ" lambda y: Nat. (lambda x:Bool."succ(zero)") "true"\
->_beta lambda y: Nat. "succ(zero)"\
->_beta "succ(zero)"
$

Es valor

== e.

$x$ no es un valor

== f.

succ(succ(zero)) = $underline(2)$

Es valor

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

== a.

#let tpares = rule.with(name: [T-Pares])
#let tpi1 = rule.with(name: [T-$pi_1$])
#let tpi2 = rule.with(name: [T-$pi_2$])

#prooftree(
    tpares($Gamma tack angle.l M,N angle.r : sigma times tau $,
        ($Gamma tack M:sigma $),
        ($Gamma tack N:tau $)
    )
)

#prooftree(
    tpi1($Gamma tack pi_1 (M):sigma$,
        ($Gamma tack M:sigma times tau$)
    )
)


#prooftree(
    tpi2($Gamma tack pi_2 (M):tau$,
        ($Gamma tack M:sigma times tau$)
    )
)

== b.

=== I. $sigma -> tau -> (sigma times tau)$

#prooftree(
    tabs($tack lambda x: sigma. lambda y: tau. angle.l x,y angle.r : sigma -> tau -> (sigma times tau)$,
        tabs($x:sigma tack lambda y:tau. angle.l x,y angle.r: tau -> (sigma times tau)$,
            tpares($Gamma = {x:sigma, y:tau} tack angle.l x,y angle.r: (sigma times tau)$,
                tvar($Gamma tack x:sigma$),
                tvar($Gamma tack y:tau$)
            )
        )
    )
)

=== II. $(sigma times tau) -> sigma$ y $(sigma times tau) -> tau$

*Caso 1*

#prooftree(
    tabs($tack lambda x:(sigma times tau).pi_1 (x):(sigma times tau)-> sigma$,
        tpi1($x:(sigma times tau) tack pi_1 (x):sigma$,
            tvar($x:(sigma times tau) tack x:(sigma times tau)$)
        )
    )
)

*Caso 2*

#prooftree(
    tabs($tack lambda y:(sigma times tau).pi_2 (y):(sigma times tau)-> tau$,
        tpi2($y:(sigma times tau) tack pi_2 (y):tau$,
            tvar($y:(sigma times tau) tack y:(sigma times tau)$)
        )
    )
)

=== III. $(sigma times tau) -> (tau times sigma)$

#prooftree(
    tabs($tack lambda x:(sigma times tau). angle.l pi_2(x),pi_1(x) angle.r:(sigma times tau) -> (tau times sigma)$,
        tpares($x:(sigma times tau) tack angle.l pi_2(x),pi_1(x) angle.r:(tau times sigma)$,
            tpi2($x:(sigma times tau) tack pi_2(x):tau$,
                tvar($x:(sigma times tau) tack x:(sigma times tau)$)
            ),
            tpi1($x:(sigma times tau) tack pi_1(x):sigma$,
                tvar($x:(sigma times tau) tack x: (sigma times tau)$)
            )
        )
    )
)

=== IV. $((sigma times tau) times rho) -> (sigma times (tau times rho))$ y $(sigma times (tau times rho)) -> ((sigma times tau) times rho)$

#let sal = $angle.l$
#let sar = $angle.r$

*Caso 1*

#prooftree(
    tabs($tack lambda x:((sigma times tau) times rho). sal pi_1(pi_1(x)), sal pi_2(pi_1(x)), pi_2(x) sar sar :((sigma times tau) times rho) -> (sigma times (tau times rho))$,
        tpares($ Gamma = x:((sigma times tau) times rho) tack sal pi_1(pi_1(x)), sal pi_2(pi_1(x)), pi_2(x) sar sar :(sigma times (tau times rho))$,
            tpi1($Gamma tack pi_1(pi_1(x)):sigma$,
                tpi1($Gamma tack pi_1(x):(sigma times tau)$,
                    tvar($Gamma tack x:(sigma times tau) times rho$)
                )
            ),
            tpares($Gamma tack sal pi_2(pi_1(x)), pi_2(x) sar:(tau times rho)$,
                tpi2($Gamma tack pi_2(pi_1(x)):tau$,
                    tpi1($Gamma tack pi_1(x):(sigma times tau)$,
                        tvar($Gamma tack x:(sigma times tau) times rho$)
                    )
                ),
                tpi2($Gamma tack pi_2(x):rho$,
                    tvar($Gamma tack x:(sigma times tau) times rho$)
                )
            )
        )
    )
)

*Caso 2*

#prooftree(
    tabs($tack lambda x :(sigma times (tau times rho)). sal sal pi_1(x) , pi_1(pi_2(x)) sar , pi_2(pi_2(x)) sar :(sigma times (tau times rho)) -> ((sigma times tau) times rho)$,
        tpares($Gamma = x :(sigma times (tau times rho)) tack sal sal pi_1(x) , pi_1(pi_2(x)) sar , pi_2(pi_2(x)) sar :((sigma times tau) times rho)$,
            tpares($Gamma tack sal pi_1(x) , pi_1(pi_2(x)) sar:(sigma times tau)$,
                tpi1($Gamma tack pi_1(x):sigma$,
                    tvar($Gamma tack x:(sigma times (tau times rho))$)
                ),
                tpi1($Gamma tack pi_1(pi_2(x))):tau$,
                    tpi2($Gamma pi_2(x):(tau times rho)$,
                        tvar($Gamma tack x:sigma times (tau times rho)$)
                    )
                )
            ),
            tpi2($Gamma tack pi_2(pi_2(x)):rho$,
                tpi1($Gamma tack pi_2(x):(tau times rho)$,
                    tvar($Gamma tack x: (sigma times (tau times rho))$)
                )
            )
        )
    )
)

=== V. $((sigma times tau) -> rho) -> (sigma -> tau -> rho)$ y $(sigma -> tau -> rho) -> ((sigma times tau) -> rho)$

*Caso 1*

#prooftree(
    tabs($tack lambda f:(sigma times tau) -> rho. lambda x:sigma. lambda y:tau. f sal x,y sar:((sigma times tau) -> rho) -> (sigma -> tau -> rho)$,
        tabs($f:(sigma times tau) -> rho tack lambda x:sigma. lambda y:tau. f sal x,y sar: sigma -> tau -> rho$,
            tabs($f:(sigma times tau), x:sigma -> rho tack lambda y:tau. f sal x,y sar: tau -> rho$,
                tapp($Gamma = f:(sigma times tau)-> rho, x:sigma,y:tau  tack f sal x,y sar: rho$,
                    tvar($Gamma tack f : (sigma times tau) -> rho$),
                    tpares($Gamma tack sal x,y sar:(sigma times tau)$,
                        tvar($Gamma tack x:sigma$),
                        tvar($Gamma tack y:tau$)
                    )
                )
            )
        )
    )
)

*Caso 2*

#prooftree(
    tabs($lambda f:(sigma -> tau -> rho). lambda p:(sigma times tau).f" " pi_1(p)" "pi_2(p):(sigma -> tau -> rho) -> ((sigma times tau) -> rho)$,
        tabs($f:(sigma -> tau -> rho) tack lambda p:(sigma times tau).f" " pi_1(p)" "pi_2(p):((sigma times tau) -> rho)$,
            tapp($Gamma = f:(sigma -> tau -> rho),p:(sigma times tau) tack f" " pi_1(p)" "pi_2(p): rho$,
                tapp($Gamma tack f " " pi_1(p): tau -> rho$,
                    tvar($Gamma tack f:sigma -> tau -> rho $),
                    tpi1($Gamma tack pi_1(p): sigma$,
                        tvar($Gamma tack p: (sigma times tau)$)
                    )
                ),
                tpi2($Gamma tack pi_2(p) : tau $,
                    tvar($Gamma tack p:(sigma times tau)$)
                )
            )
        )
    )
)

== c.

$V::= dots | angle.l V,V angle.r $

== d.

*Si* $M -> M'$ *entonces* $pi_1(M) -> pi_1(M')$

*Si* $M -> M'$ *entonces* $pi_2(M) -> pi_2(M')$

$pi_1(angle.l V,W angle.r) -> V$

$pi_2(angle.l V,W angle.r) -> W$

*Si* $M -> M'$ *entonces* $angle.l M, N angle.r -> angle.l M',N angle.r$

*Si* $N -> N'$ *entonces* $angle.l V, N angle.r -> angle.l V, N' angle.r$

== e.

La demostración queda de ejercicio al lector

#pagebreak()

= 22


== a.

*Primer ejemplo*

#tree[case zero :: succ(zero) $[]_Nat$ of ${[] ~> "false" | x::x s ~> "izZero"(x)} ->> "true"$
    []
]


*Segundo ejemplo*

#pagebreak()

= 23

#pagebreak()

= 24

#pagebreak()

= 27