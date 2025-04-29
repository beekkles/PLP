take' :: [Int] -> Int -> [Int]
take' xs e = foldr (\(i, x) acc -> if i >= e then x:acc  else acc ) [] (zip [1..] xs)


-- take'' :: [Int] -> Int -> [Int]
-- take'' = foldr (\x rec -> \n -> if n==0 then [] else x:rec (n-1) (const []))

-- insertarABB :: Ord a => a -> AB a -> AB a

type Conj a = (a->Bool)

vacio :: Conj a
vacio = const False

agregar :: Eq a => a -> Conj a -> Conj a
agregar e c = \x -> x == e || c x

union :: Conj a -> Conj a -> Conj a
union c c' =\x ->
    
    
    
    
     c x && c' x