{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use tuple-section" #-}
rv :: [a] -> [a]
rv = foldr (\x acc -> acc ++ [x]) []

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

trimm :: String -> String
trimm = recr (\x xs acc -> if x == ' ' then acc else x:xs) []


data Forma = Rectangulo Float Float
            | Circulo Float 


area :: Forma -> Float
area (Rectangulo ancho alto) = ancho * alto
area (Circulo radio) = radio * radio * pi



data Nat = Zero | Succ Nat


doble :: Nat -> Nat
doble Zero = Zero
doble (Succ n) = Succ (Succ (doble n))


productoCartesiano :: [a] -> [b] -> [(a,b)]
productoCartesiano [] ys = []
productoCartesiano (x:xs) ys = productoCartesiano xs ys ++ map (\y -> (x,y)) ys

data AB a = Nil | Bin (AB a) a (AB a)

inorder :: AB a -> [a]
inorder Nil = []
inorder (Bin i r d) = inorder i ++ [r] ++ inorder d


foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fNil fBin Nil = fNil  
foldAB fNil fBin (Bin i r d) = fBin (foldAB fNil fBin i) r (foldAB fNil fBin d)

