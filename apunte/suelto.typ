#set page(paper: "a4")
#set text(size: 10pt)
= GLOSARIO

```

curry :: ((a, b) -> c) -> a -> b -> c -- Devuelve una función currificada
curry f x y = f (x, y)
uncurry :: (a -> b -> c) -> (a, b) -> c -- Devuelve una función no currificada
uncurry f (x, y) = f x y
```

*Folds*

```
foldr :: (a -> b -> b) -> b -> [a] -> b  -- Fold derecho (asociativo a derecha).
foldl :: (b -> a -> b) -> b -> [a] -> b  -- Fold izquierdo (asociativo a izquierda).
foldr1 :: (a -> a -> a) -> [a] -> a      -- `foldr` en listas no vacías.
foldl1 :: (a -> a -> a) -> [a] -> a      -- `foldl` en listas no vacías.
```

*Listas*

``` 
map :: (a -> b) -> [a] -> [b]                     -- Aplica función a cada elemento.
filter :: (a -> Bool) -> [a] -> [a]    -- Filtra elementos que cumplen un predicado.
concat :: [[a]] -> [a]                            -- Concatena listas anidadas.
concatMap :: (a -> [b]) -> [a] -> [b]             -- `concat . map`.
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]     -- Combina listas con una función.
reverse :: [a] -> [a]                             -- Invierte la lista.
```

*Cosas sobre listas*

``` 
(++) :: [a] -> [a] -> [a]      -- Concatena listas.
head :: [a] -> a               -- Primer elemento (error si vacía).
tail :: [a] -> [a]             -- Lista sin el primer elemento.
init :: [a] -> [a]             -- Lista sin el último elemento.
last :: [a] -> a               -- Último elemento (error si vacía).
length :: [a] -> Int           -- Longitud de la lista.
null :: [a] -> Bool            -- Verifica si la lista está vacía.
replicate :: Int -> a -> [a]   -- Repite un elemento `n` veces.
take :: Int -> [a] -> [a]      -- Toma los primeros `n` elementos.
drop :: Int -> [a] -> [a]      -- Elimina los primeros `n` elementos.
```

*Búsqueda*

```
elem :: Eq a => a -> [a] -> Bool   -- Verifica si un elemento está en la lista.
any :: (a -> Bool) -> [a] -> Bool  -- Verifica si algún elemento cumple el predicado.
all :: (a -> Bool) -> [a] -> Bool  -- Verifica si todos cumplen el predicado.
```

*Orden y duplicados*

```
sort :: Ord a => [a] -> [a]                  -- Ordena una lista.
sortBy :: (a -> a -> Ordering) -> [a] -> [a] -- Ordena con función de comparación.
nub :: Eq a => [a] -> [a]                    -- Elimina elementos duplicados.
union :: Eq a => [a] -> [a] -> [a]           -- Unión de conjuntos (sin duplicados).
intersect :: Eq a => [a] -> [a] -> [a]       -- Intersección de conjuntos.
```

*Aritmética, lógica y comparación*

```
sum :: Num a => [a] -> a                          -- Suma de elementos.
mod :: Integral a => a -> a -> a                  -- Módulo.
div :: Integral a => a -> a -> a                  -- División entera.
odd :: Integral a => a -> Bool                    -- Verifica si es impar.
even :: Integral a => a -> Bool                   -- Verifica si es par.
and :: [Bool] -> Bool                             -- AND lógico sobre una lista.
or :: [Bool] -> Bool                              -- OR lógico sobre una lista.
not :: Bool -> Bool                               -- Negación lógica.
(==), (/=) :: Eq a => a -> a -> Bool              -- Igualdad/desigualdad.
compare :: Ord a => a -> a -> Ordering            -- Compara (`LT`, `EQ`, `GT`).
comparing :: Ord a => (b -> a) -> b -> b -> Ordering -- Compara usando una función.
max, min :: Ord a => a -> a -> a                  -- Máximo/mínimo entre dos valores.
maximum, minimum :: Ord a => [a] -> a             -- Máximo/mínimo de una lista.
maximumBy, minimumBy :: (a -> a -> Ordering) -> [a] -> a -- Máximo/mínimo con comparador.
```
#pagebreak()
//#set text(size: 12pt)

== Esquemas de recursión:
- *Estructural:* permite acceder a los argumentos no recursivos de los constructores, y a los resultados de la recursión para las subestructuras.
- *Primitiva:* como la estructural, pero además permite acceder a las subestructuras.
- *Global:* como la primitiva, pero además permite acceder a los resultados de las recursiones anteriores

*Ejemplos:*

```
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

insertarOrdenado e [] = [e]
insertarOrdenado e (x:xs) = if e < x then e:x:xs
                                     else x:(insertarOrdenado e xs)

elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs then [x]
                                  else x:elementosEnPosicionesPares (tail xs)
```

1. La recursión de `longitud` es *estructural*, porque hace recursión sobre la cola de la lista (xs) pero no accede a la cola en sí, ni a resultados de recursiones anteriores.
2. La recursión de `insertarOrdenado` es *primitiva* porque accede directamente a xs (además de hacer recursión), pero no accede a los resultados anteriores.
3. La recursión de `elementosEnPosicionesPares` es *global*, ya que accede a un resultado anterior: el de la recursión sobre la cola de la cola de la lista (es decir tail xs).

== Funciones clave:

```
foldr :: (a -> b -> b) -> b -> [a] -> b -- Estructural
foldr _ z []     = z
foldr f z (x:xs) = f x (foldr f z xs)

foldl :: (b -> a -> b) -> b -> [a] -> b -- Estructural
foldl _ z []     = z 
foldl f z (x:xs) = foldl f (f z x) xs

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b -- Primitiva
recr _ z []     = z
recr f z (x:xs) = f x xs (recr f z xs)
```

== Construcción de folds personalizados:

Un esquema de recursión estructural espera recibir un argumento por cada
constructor (para saber qué devolver en cada caso), y además la estructura que
va a recorrer.

El tipo de cada argumento va a depender de lo que reciba el constructor
correspondiente. (¡Y todos van a devolver lo mismo!)

Si el constructor es recursivo, el argumento correspondiente del fold va a recibir el
resultado de cada llamada recursiva.

*Un pequeño ejemplo:*

```
data AB a = Hoja | Nodo (AB a) a (AB a)
  -- Constructor base: Hoja
  -- Constructor recursivo: Nodo

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB casoHoja _ Hoja = casoHoja  -- Para Hoja
foldAB casoHoja f (Nodo izq val der) = 
   f (foldAB casoHoja f izq) val (foldAB casoHoja f der)
   -- Para Nodo: recibe resultados recursivos (izq/der) y el valor 'val'
```

#pagebreak()

*Extensionalidad:*
```
Dadas f, g :: a -> b, probar f = g se reduce a probar:
                              ∀ x::a . f x = g x
```

*Propiedades útiles:*

```
∀F :: a -> b . ∀G :: a -> b . ∀Y :: b . ∀Z :: a .
```

1. `F = G        ` $<=>$ `  ∀x::a. F x = G x`

2. `F = \x -> Y  ` $<=>$ `  ∀x::a. F x = Y`

3. `(x -> Y) Z   ` $=_beta$ `Y` reemplazando `x` por `Z`

4. `\x -> F x    ` $=_eta$ `F`

F, G, Y y Z pueden ser expresiones complejas, siempre que `x` no aparezca libre en F, G, ni Z

*Ejemplos*

2. `F x = x * 2   y   G = \x -> x * 2   =>   F = G`

3. `(\x -> x + 5) 3 =β (3 + 5)`

*Lemas de generación*

*Para pares:*  `Si p :: (a, b), entonces ∃x :: a. ∃y :: b. p = (x, y).`



*Para sumas* `data Either a b = Left a | Right b`:

```
Si e :: Either a b, entonces:
  o bien ∃x :: a. e = Left x
  o bien ∃y :: b. e = Right y
```

*Idea general para una demostración por inducción estructural*

- Leer la propiedad, entenderla y convencerse de que es verdadera.
- Plantear la propiedad como predicado unario.
- Plantear el esquema de inducción.
- Plantear y resolver el o los caso(s) base.
- Plantear y resolver el o los caso(s) inductivo(s).

*Dato:* Los argumentos no recursivos quedan cuantificados universalmente.

#image("image.png", height: 4.5cm)
#image("image-1.png", height: 4.5cm)
#image("image-2.png", height: 9cm)

Si no podemos continuar en un paso de la demostración, optamos por demostrar un lema sobre la operación.

#pagebreak()


= Lógica intuicionista

== Reglas básicas:

#image("image-4.png", height: 8cm)
#image("image-5.png", height: 8cm)
== Reglas derivadas:
#grid(columns: 2)[#image("image-6.png", height: 1.6cm)
][#image("image-7.png", height: 1.6cm)
]

= Lógica clásica

#grid(columns: 2)[== Reglas básicas:
#image("image-8.png", height: 1.6cm)][
== Reglas derivadas:
#image("image-9.png", height: 1.3cm)]

#pagebreak()

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

#set text(size: 15pt)
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

Podemos también expresar macros, como:

$"curry"_(sigma,tau,delta) = lambda f: sigma times tau -> delta. lambda x: sigma. lambda y: tau. f angle.l x,y angle.r$

*IMPORTANTE:
*

A la hora de hacer reglas de tipado, hay que hacer una para cada expresión nueva.

Luego hay que extender el conjunto de valores.

Hay que hacer reglas de congruencia que mantengan determinismo (ir reduciendo congruentemente parte por parte)

Hay que hacer axiomas para cada valor nuevo del conjunto de valores

#pagebreak()