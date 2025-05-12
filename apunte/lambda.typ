= Sintaxis y tipado
== Cosas a tener en cuenta

#image("image-20.png")


== Tipos y términos
#image("image-12.png")
== Axiomas y reglas de tipado
#image("image-13.png", height: 6cm)
#image("image-14.png", height: 6cm)

= Semántica operacional

#image("image-15.png", height: 1.8cm)

== Reglas de evaluacion en un paso
== Propiedades de la evaluación:
#image("image-22.png", height: 9cm)
#image("image-16.png", height: 3.5cm)

#set text(size: 16pt)
Ejemplos:

$mu$:

$underbrace((lambda x: "Nat".x)(lambda y: "Nat".y), M_1)" "underbrace(3, M_2) ->_beta underbrace((lambda y: "Nay".y), M_1 ')" "underbrace(3, M_2)$

$nu$:

$underbrace((lambda x: "Nat"."succ"(x)), V)underbrace(((lambda y: "Nat".y)" "3), M_2) ->_beta underbrace((lambda x:"Nat"."succ"(x)), V)" "underbrace(3,M_2 ')$

$beta$:

$(lambda x: "Nat"."succ"(x))" "2 -> "succ"(x) {x::=2}= "succ"(2)$

#image("image-17.png", height: 4cm)

#image("image-18.png", height: 7cm)

#image("image-23.png", height: 1.4cm)

