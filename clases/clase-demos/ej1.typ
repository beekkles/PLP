
qpq 

$
"length2" = "length1" \

"length2" =_({"L2"}) = "foldr (\_ res" -> "1+res)" \

"Por extensionalidad, basta con probar" forall "xs" ... [a] \

"Por inducción en xs"\
P("xs"): ("foldr (\_ res" -> "1+res)" 0) "xs" = "length1 xs" \


$

Caso base:

$ 
  "foldr (\_ res" -> "1+res) 0 []" =_{"F0"}\

  "length1" [] =_{"L10"} 0
  
$

Paso inductivo xs = y:ys:

$
  "HI"= P("ys") "foldr(\_ res " -> "1+res 0) ys" = "length1 ys"\
  "TI": P("y:ys")
  
$


$
  "foldr(\_ res" -> "1+res) 0 (y:ys)" = "length1 (y:ys)" \

  =_{"F1"} "(\_ res" -> "1+res) y (foldr (\_ res -> 1+res) 0 ys)"\
  =_(2beta) "1+foldr (\_ res -> 1+res) 0 ys" =_{"HI"} "1+length1 ys" =_{"L11"} "length1 (y:ys") square

$

#line(length: 100%)
#pagebreak()