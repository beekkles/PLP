#image("image.png")

Por inducción en ys:

#line(length: 100%)

*Caso ys = [ ]*

P([ ]) = elem e [ ] $=>$ e $<=$ maximum [ ]

elem e [ ] $=_{"E0"}$ False

Por Bool, la implicación es verdadera.


#line(length: 100%)

*Caso ys = x:xs*

HI = P(xs)

qvq $forall$ e:: a, elem e (x:xs) $=>$ e $<=$ maximum (x:xs)

$=_{"E1"}$ e == x || elem e xs $=>$ e $<=$ maximum (x:xs)

L.G. Bool $=>$ e==x = True $or$ e==x = False

L.G. Listas $=>$ xs = [ ] $or$ xs = z:zs

#line(length: 70%)

Caso e==x = True $=>$ xs = [ ]

$star =_{"Bool"}$ = True $=>$ e $<=$ maximum (x [ ])

$=_{"Bool"}$ e $<=$ maximum (x [ ])

$=_{"M0"}$ e $<=$ x $=_{"Ord (e==x)"}$ True

#line(length: 70%)

Caso e==x = False $=>$ xs = [ ]

$star =_{"Bool"}$ elem e [ ] $=>$ e $<=$ maximum [ ] $._"vale por caso base"$


#line(length: 70%)

Caso e==x = True, xs = z:zs

$star =_{"Bool"}$ e $<=$ maximum (x:z:zs) $=_{"M1"}$ e $<=$ if x $<$ maximum (z:zs) then maximum (z:zs) else x

L.G. Bool $=>$ x $<$ maximum (z:zs) es True o False

#line(length: 50%)
Caso True:

Por Ord, e==x $<$ maximum (z:zs) $=>$ e $<=$ maximum (z:zs) $=_{"if"}$

#line(length: 50%)

Caso False:

$=_{"If"} $ e $<=$ x vale por Ord y e==x

Caso e==x es False, xs es z:zs

$=_{"Bool"}$ elem e (z:zs) $=>$ elem $<=$ maximum (x:z:zs)

$=_{"M1"}$ elem e (z:zs) $=>$ e $<=$ if x $<$ maximum (z:zs) then maximum (z:zs) else x

#line(length: 50%)

LG Bool

Caso True:

elem e(z:zs) $=>$ e $<=$ maximum (z:zs) vale por HI

Caso False:

elem e (z:zs) $=>$ e $<=$ x

LG. Bool

False la implicación es verdadera

Caso True qvq e $<=$ x 

Por HI, Bool e $<=$ maximum (z:zs) $<$ x para todo e $<=$ x $square$

#pagebreak()
#image("image-1.png")


length ys $=^?$ length (reverse ys)

length (reverse ys) $=_{R}$ length (foldl flip (:)) [ ]

...

*Nota* vamos a llegar a foldl (flip (:)) (x:[ ]) xs, luego no se puede usar HI, luego:

*Lema:* $forall$ ac :: [a], $forall$ ys:: [a]. length (foldl (flip (:)) ac ys) = length ys + length ac

Lo probamos por inducción en ys:

P(ys) = $forall$ ac::[a] length (foldl (flip (:)) ac ys) = length ac + length ys

#line(length: 70%)

Caseo ys = [ ]

length (foldl flip (:)) ac [ ] $=_{"F0"}$ length ac $=_{"Int"}$ = 0+length ac $=_"{L0}"$ length [] + length ac

*Tarea: caso ys = x:xs*

#line(length: 70%)

#pagebreak()

#image("image-2.png")

Por extensionalidad basta probar que 

$forall$ xs::[a], take' xs = flipTake xs

Por extensionalidad

$forall$ xs::[a] $forall$ n:: Int xs n = flipTake xs n 

Inducción en xs

P(xs): $forall$ n::Int tak xs n = flipTake xs n 

#line()

Caso xs = [ ]

take' [] n $=_{"T0"}$ [ ]

- (*notamos* f = (\x rec n -> if n == 0 then [] else x : rec (n-1)))

flipTake [] n $=_{"FT"}$ foldr f (const [ ]) n $=_{"foldr"}$ const [] n $=_{"const"}$ []

#line()

Caso xs = y:ys

HI = P(xs)

take' (y:ys) n $=_{"T1"}$ if n==0 then [ ] else y take' ys (n-1)

fliptake (y:ys) n = foldr f [ ] (y:ys) n $=_{"foldr"}$ f y (foldr f [ ] ys) n $=_beta$ (\\rec n $->$ if n==0 then [] else y:(rec (n-1)) (foldr f const [ ] ys)) n

$=_{2beta}$ if n==0 then [ ] else y (foldr f (const [ ] ys)) (n-1) 

if n==0 then [ ] else y flipTake ys (n-1)) $=_{"HI"}$

if n==0 then [ ] else y take' ys (n-1) $square$

#line(length: 100%)

#pagebreak()

#image("image-3.png")

Inducción en t 

P(t) = cantNodos t = length (inorder t)

Caso t= Nil

cantNodos Nil $=_{"CN0"}$ 0

???


Caso t = Bin i r d

HI = P(i) $and$ P(d)

cantNodos (Bin i r d) $=_{"CN1"}$ 1 + (cantNodos i) + (cantNodos d)

$=_{"HI"}$ 1 + length(inorder i) + length(inorder d)

length (inorder (Bin i r d)) $=_{"I1"}$ length ((inorder i) ++ (r:inorder d))

$=_{"Lema"}$ length (inorder i) + length (r:inorder d)

$=_{"L1, Int"}$ 1 + length (inorder i) + length (inorder d) $square$


#pagebreak()


#image("image-4.png")

Caso base 

- q = Hoja h con h::a 

Caso inductivo 1

- q = Dos x i d con x::b, i,d::Arbol123 a b

HI: P(i) $and$ P(d)

Caso inductivo 2

- q = Tres x i m d con x::b, i,m,d:: Arbol123 a b

HI: P(i) $and$ P(d) $and$ P(m)

