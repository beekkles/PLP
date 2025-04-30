#import "@preview/curryst:0.5.1": rule, prooftree
#import "@preview/lambdabus:0.1.0" as lmd

#let t-true = rule.with(name: [T-True])

#let t-false = rule.with(name: [T-False])

#let t-var = rule.with(name: [T-Var])

#let t-if = rule.with(name: [T-If])

#let t-abs = rule.with(name: [T-Abs])

#let t-app = rule.with(name: [T-App])

#let t-zero = rule.with(name: [T-Zero])

#let t-pred = rule.with(name: [T-Pred])

#let t-succ = rule.with(name: [T-Succ])

#let t-fix = rule.with(name: [T-Fix])

#let t-iszero = rule.with(name: [T-IsZero])

#let Bool = "Bool"

= Sintaxis

$sigma ::= "Bool" | sigma -> sigma$

Gramática de términos

$M::= x | lambda x: sigma. M | M M | "true" | "false" | "if" M "then" M "else" M$

donde $x in cal(X)$ el conj de todas las variables. Llamamos $cal(T)$ al conj de todos los términos.


una variable libre es la que está fuera del scope del $lambda$, contrario a ligada.

$"fv": cal(T)->cal(P(X))$

== ej.

$"fv"(x) = {x}$

$"fv"(lambda x: sigma. M) = "fv"(M)\\{x}$

$"fv"(M N)= "fv"(M) union "fv"(N)$

== ejercicios.
#prooftree(
  rule($lambda x: Bool -> Bool. x "true"$,
    rule($x "True"$,
      rule($x$),
      rule("True")
    )
  )
)


#prooftree(
  rule($x y lambda x . B -> B. x y$,
    rule($x y$,
      rule($x$),
      rule($y$)
    ),
    rule($lambda x. B -> B. x y$,
      rule($x y$,
        rule($x$),
        rule($y$)
      )
    )
  )
)

#prooftree(

  rule($(lambda x: B -> B. x y) (lambda y: B.x)$,
    rule($lambda x: B -> B.x y$,
      rule($x y$,
        rule($x$),
        rule($y$)
      )
    ),
    rule($lambda y: B .x$,
      rule($x$)
    )
  )
)

#prooftree(
  rule($"if" x "then" y "else" lambda z : Bool. z$,
    rule($x$),
    rule($y$),
    rule($lambda z: B z$,
      $z$
    ),
  )

)

= Tipado

== 1
#prooftree(
  t-app($tack(lambda x : Bool. lambda y : Bool. "if" x "then true" "else" y) "false": Bool -> Bool$,
    t-abs($tack lambda x: Bool . lambda y: Bool "if" x "then true else" y$,
      t-abs(${x: Bool} tack lambda y: Bool "if" x "then true else" y: Bool -> Bool$,
        t-if($Gamma={x:Bool,y:Bool} tack "if" x "then else" y : Bool$),
          t-var($Gamma tack x:Bool$),
          t-true($Gamma tack "true":Bool$),
          t-var($Gamma tack y: Bool$)        
      )
    ),
    t-false($tack "false": Bool$),
  )

)

== 2 se queda trabado


#prooftree(
  t-if($tack "if" x "then" x "else" z:Bool$,
    rule(text(red)[$tack x:Bool$]),
    rule(text(red)[$tack x:Bool$]),
    rule(text(red)[$tack z:Bool$])
  )
)


== 3

#prooftree(
  t-if(${x:Bool} tack "if" x "then" x "else" (lambda y: Bool. y)$,
    rule($Gamma tack x:Bool$),
    rule(text(red)[${x:Bool} tack x: Bool -> Bool$]),
    rule($Gamma tack lambda y : Bool. y: Bool->Bool$)
  ) 
)

== 4 identificar tipos de $sigma, tau, rho$

#prooftree(
  t-abs($lambda x : rho. lambda y : sigma. lambda z: tau. x (x y z): (rho -> sigma-> tau -> alpha)$,
    t-abs(${x:rho} tack lambda y.sigma. lambda z tau. x (x y z) : sigma -> tau -> alpha$,
      t-abs(${x:rho, y:sigma} tack lambda z tau. x (x y z): tau -> alpha$,
        t-app($Gamma={x:rho, y:sigma,z:tau} tack x (x y z): alpha$,
          t-var($Gamma tack x: epsilon -> alpha$,
            rule($rho = epsilon -> alpha$)
          ),
          rule($Gamma tack x y z : epsilon$,
            t-app($Gamma tack x y : tau -> epsilon$,
              t-var($Gamma tack x: sigma -> tau -> epsilon$,
                rule($rho = sigma -> (tau->epsilon)$)
              ),
              t-var($Gamma tack y:rho$)
            ),
            rule($Gamma tack z: tau$)
          )
        )
      )
    )
  )
)

*derivamos*

$epsilon = sigma$

$alpha = tau -> epsilon = tau -> sigma$

$=> rho = sigma -> tau -> sigma$

Y queda

$lambda x:sigma -> tau -> sigma. lambda y : sigma. lambda z: tau . x(x y z): (sigma -> tau -> sigma) -> sigma -> tau -> tau -> sigma$ $::forall sigma, tau$

= tipos habitados.

== ejemplo.

$"id"_sigma =^"def" lambda x : sigma. x$ es de tipo $sigma -> sigma$

i.e.

 $tack "id"_sigma : sigma -> sigma$

= Demostrar si los siguientes tipos están habitados, $forall sigma, tau, rho$

== a.

$sigma -> tau->sigma$

$tack lambda x: sigma . lambda y: tau . x : sigma -> tau -> sigma$

== b

$(tau -> rho) -> (sigma -> tau) -> (sigma -> rho)$

$tack lambda f : tau -> rho. lambda g : sigma -> tau. lambda x: sigma$

i.e. $f(g (x)): (tau -> rho) -> (sigma -> tau) -> (sigma -> rho)$

== c

$sigma -> tau$

$tack lambda x : sigma. mu(lambda x : sigma . M) : sigma -> tau$

$tack lambda x : sigma. mu(lambda x : sigma . M) : sigma -> tau$


= Semántica operacional.

$lambda x : Bool. (lambda y. Bool. x) "false"$ *es un valor*

$(lambda y. Bool. x)->M:: (lambda x: sigma . M )$
#line()

$((lambda x : Bool . lambda y: Bool. "if" x "then true else" y) "false") "true" --> beta, mu$

$(lambda y. Bool. "if false then true else y") "true"$

$-->_beta "if false then true else true" ->_"E-IfFalse" "true"$

#line()

$
&(lambda x : Bool. lambda y: Bool -> Bool. y (y x)) ((lambda z : Bool. "true") "false")(lambda w: Bool. w) &-->_(mu,nu,beta) \


&(lambda x: Bool . lambda y : Bool -> Bool . y (y x)) "true" (lambda w : Bool . w) &-->_(mu, beta) \

&(lambda y: Bool -> Bool . y (y "true")) (lambda w: Bool. w) &-->_(mu,beta) \

&(lambda y. Bool -> Bool. y (y "true")) (lambda w. Bool. w) &-->_beta \

&(lambda w: Bool. w) ((lambda w: Bool. w) "true") &-->_(nu, beta) \

&(lambda w: Bool. w) "true" &-->_(beta) \

&"true"$


#line()

*Casos base*

E-IfTrue/False

$beta$

*Casos recursivos*

E-if

$mu$

$nu$


*Caso base 1:*

M reduce con E-IfTrue 

M:= if true then $M_1$ else $M_2$ $--> "E-IfTrue"$ $M_1$

sup que $M' "/" M->M', M' != M_1$

*No puede pasar* E-If porque la guarda es un valor, no $beta,mu,nu$ porque no es una aplicación.



*Caso rec 1*

M reduce con $mu$ M:= $M_1 M_2$

*HI*: si $M_1 -> M_1 ' and M_1 -> M_1 '', M_1 ' = M_1 ''$

Sea N tal que $M_1 -> N M_2$

No podemos aplicar E-If pq' no es apl.

No podemos $beta$ pq' $M_1$ no es un valor

No podemos $nu$ pq' $M_1$ no es un valor

¿$M_1 -> N' "/" N!=N'$?

*NO* pq', por HI, si $M_1 -> M_1 ' and M_1 -> M_1 '', M_1 ' = M_1 ''$


= Extensión con numeros naturales.

#let Nat = "Nat"
#let succ = "succ"
#let zero = "zero"

== a.

#prooftree(
  t-app($tack (lambda x : Nat succ(x) zero : Nat)$,
    t-abs($tack (lambda x: Nat. succ(x))$,
      t-succ($x: Nat tack succ(x). Nat$,
        t-var($x: Nat tack x.Nat$)
      )
    ),
    t-zero($tack zero: N$)
  )
)

== d.

$"izZero"(succ("pred"(succ("Zero")))) --> "E-isZero E-PredSucc E-Succ"$

$"izZero"(succ("Zero")) --> ("E-isZero"_n)$

false 

#line(length: 100%)

#text(red)[*NO VALE DERIVAR MAS DE UN PASO A LA VEZ*]

V::= true | false | zero | succ(V) | $lambda x: sigma. "F"$ 

$lambda x: Bool . "if true then x else false" -->\
lambda x: Bool . x

$