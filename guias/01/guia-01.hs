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

mapPares :: ((a,b) -> c) -> [(a,b)] -> [c]
mapPares f = foldr (\(x,y) acc -> f (x,y) : acc) []

armarPares :: [a] -> [b] -> [(a,b)]
armarPares [] _           = []
armarPares _ []           = []
armarPares (x:xs) (y:ys)  = (x,y): armarPares xs ys

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble _ [] _           = []
mapDoble _ _ []           = []
mapDoble f (x:xs) (y:ys)  = f x y : mapDoble f xs ys

--9--------------------------------------------------------------------------------
data Nat = Cero | Succ Nat 
  deriving Show

foldNat :: b -> (b -> b) -> Nat -> b
foldNat z _ Cero     = z
foldNat z f (Succ a) = f (foldNat z f a)

sumNat :: Nat -> Nat -> Nat
sumNat Cero _            = Cero
sumNat _ Cero            = Cero
sumNat (Succ a) (Succ b) = foldNat (Succ a) Succ (Succ b)

mulNat :: Nat -> Nat -> Nat
mulNat a (Succ Cero)     = a
mulNat a (Succ b)        = sumNat a (mulNat a b)

potNat :: Nat -> Nat -> Nat
potNat p = foldNat (Succ Cero) (mulNat p)