--3-------------------------------------------------------------------------------

sum' :: Num a => [a] -> a
sum' = foldr1 (+)

elem' :: Eq a => a -> [a] -> Bool
elem' e = foldr (\x acc -> x==e || acc) False

masmas' :: [a] -> [a] -> [a]
masmas' = foldr (:)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\y acc -> if p y then y:acc else acc) []

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x acc -> f x:acc) []

mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x acc -> if f x acc then x else acc)

sumasParciales :: Num a => [a] -> [a]
sumasParciales [] = []
sumasParciales [x] = [x]
sumasParciales (x:y:xs) = x : sumasParciales ((x+y):xs)

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (\x acc -> x+(-1)*acc) 0

sumaAlt' :: Num a => [a] -> a
sumaAlt' = foldl (\x acc -> (-1)*x+acc) 0

--5-------------------------------------------------------------------------------

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares [x] = [x]
elementosEnPosicionesPares (x:_:xs) = x:elementosEnPosicionesPares xs

entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr f (const [])
  where
    f x acc ys = if null ys
                    then x : acc []
                    else x : head ys : acc (tail ys)

--6--------------------------------------------------------------------------------

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs acc -> if x == e then xs else x:acc) []

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs acc -> if x <= e && e <= head xs then x:e:xs else x:acc) []

--7--------------------------------------------------------------------------------

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = foldr (\(x,y) acc -> f x y : acc) []

armarPares :: [a] -> [b] -> [(a,b)]
armarPares [] _           = []
armarPares _ []           = []
armarPares (x:xs) (y:ys)  = (x,y): armarPares xs ys

-- con foldr

armarPares' :: [a] -> [b] -> [(a,b)]
armarPares' = foldr (\x acc (y:ys) -> (x,y):acc ys) (const [])
--

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble _ [] _           = []
mapDoble _ _ []           = []
mapDoble f (x:xs) (y:ys)  = f x y : mapDoble f xs ys

--9--------------------------------------------------------------------------------
data Nat = Cero | Succ Nat
  deriving Show
{-
foldNat :: (b -> b) -> b -> Nat -> b
foldNat _ z Cero     = z
foldNat f z (Succ a) = f (foldNat f z a)

sumNat :: Nat -> Nat -> Nat
sumNat Cero b            = b
sumNat a Cero            = a
sumNat (Succ a) (Succ b) = foldNat Succ (Succ a) (Succ b)

mulNat :: Nat -> Nat -> Nat
mulNat a = foldNat (sumNat a) Cero

potNat :: Nat -> Nat -> Nat
potNat p = foldNat (mulNat p) (Succ Cero)
-}

-- con Integer

foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat _ z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia b = foldNat (\_ acc -> b*acc) 1
--10--------------------------------------------------------------------------------

genLista :: a -> (a -> a) -> Integer -> [a]
genLista inicio f len = foldr (\_ g x -> x : g (f x))  (const []) [1..len] inicio

--11--------------------------------------------------------------------------------

data Polinomio a = X
                  | Cte a
                  | Suma (Polinomio a) (Polinomio a)
                  | Prod (Polinomio a) (Polinomio a)

evaluar :: Num a => a -> Polinomio a -> a
evaluar e X = e
evaluar e (Cte x) = x
evaluar e (Suma p q) = evaluar e p + evaluar e q
evaluar e (Prod p q) = evaluar e p * evaluar e q

--12--------------------------------------------------------------------------------
data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB _ z Nil = z
foldAB f z (Bin i c r) = f (foldAB f z i) c (foldAB f z r)

recAB :: (AB a -> a -> AB a -> b -> b -> b) -> b -> AB a -> b
recAB _ z Nil = z
recAB f z (Bin i c r) = f i c r (recAB f z i) (recAB f z r)

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

altura :: AB a -> Integer
altura = foldAB (\i _ r -> 1 + max i r) 0

cantNodos :: AB a -> Integer
cantNodos = foldAB (\i _ r -> i+1+r) 0

mejorSegun :: (a -> a -> Bool) -> AB a -> a
mejorSegun f (Bin i c r) = foldAB (\i c r -> mejor f c (mejor f i r)) c (Bin i c r)
  where
    mejor f x y = if f x y then x else y

esABB :: Ord a => AB a -> Bool
esABB = recAB (\i c r recI recR -> all (<= c) (abALista i) && all (>= c) (abALista r) && recI && recR) True
  where
    abALista = foldAB (\i c r -> i++[c]++r) []

--15--------------------------------------------------------------------------------

data RT a = Nodo a [RT a]

foldRT :: (a -> [b] -> b) -> RT a -> b
foldRT f (Nodo r hijos) = f r (map (foldRT f) hijos)

hojas :: RT a -> [a]
hojas = foldRT (\r hijos -> if null hijos then [r] else concat hijos)

distancias :: RT a -> [(a,Int)]
distancias rt = zip (rtALista rt) (distanciasAux rt)
  where
    rtALista =      foldRT (\r hijos -> if null hijos then [r] else concat hijos)
    distanciasAux = foldRT (\r hijos -> if null hijos then [0] else map (+1) (concat hijos))

alturaRT :: RT a -> Int
alturaRT = foldRT (\r hijos -> if null hijos then 0 else 1 + maximum hijos)