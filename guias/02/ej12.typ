= 12
Dados: 
```haskell 
data Polinomio a = X
                  | Cte a
                  | Suma (Polinomio a) (Polinomio a)
                  | Prod (Polinomio a) (Polinomio a)

        evaluar :: Num a => a -> Polinomio a -> a
{E0}    evaluar e X = e
{E1}    evaluar e (Cte x) = x
{E2}    evaluar e (Suma p q) = evaluar e p + evaluar e q
{E3}    evaluar e (Prod p q) = evaluar e p * evaluar e q

        derivado :: Num a => Polinomio a -> Polinomio a
{PL0}   derivado poli = case poli of
                X        -> Cte 1
                Cte _    -> Cte 0
                Suma p q -> Suma (derivado p) (derivado q)
                Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)

        sinConstantesNegativas :: Num a => Polinomio a -> Polinomio a
{SCN}   sinConstantesNegativas = foldPoli True (>=0) (&&) (&&)

        esRaiz :: Num a => a -> Polinomio a -> Bool
{ER0}   esRaiz n p = evaluar n p == 0
```

Queremos probar:

== I.

```hs
Num a => ∀ p::Polinomio a . ∀ q::Polinomio a . ∀ r::a . 
P(p): (esRaiz r p ⇒ esRaiz r (Prod p q))

-- Por inducción en P(p):

-- Caso base P(X):

          esRaiz r X ⇒ esRaiz r (Prod X q)
2*{ER0} = (evaluar r X) == 0 ⇒ (evaluar r (Prod X q)) == 0
{E0}    = r == 0 ⇒ (evaluar r (Prod X q)) == 0
{E3}    = r == 0 ⇒ (evaluar r X * evaluar r q) == 0
{E0}    = r == 0 ⇒ (r * evaluar r q) == 0

        -- Caso (r==0) = True:

                True ⇒ (0 * evaluar 0 q) == 0
        {E0}    True ⇒ 0 == 0
        {Bool}    True ⇒ True 
        {Bool}    True

        -- Caso (r==0) = False:

                False ⇒ r * evaluar r q
        {Bool} = True

-- Caso base P(Cte a):
-- Queremos ver que para cualquier x::a vale

        (esRaiz r (Cte x) ⇒ esRaiz r (Prod (Cte x) q))
{ER0} = (evaluar r (Cte x)) == 0 ⇒ (evaluar r (Prod (Cte x) q)) == 0
{E1}  = x == 0 ⇒ (evaluar r (Prod (Cte x) q)) == 0
{E3}  = x == 0 ⇒ (evaluar r (Cte x) * evaluar r q) == 0
{E1}  = x == 0 ⇒ (x * evaluar r q) == 0

        -- Caso (x==0) = True:

                True ⇒ (0 * evaluar r q) == 0
        {INT}   True ⇒ 0 == 0
        {Bool}  True ⇒ True
        {Bool}  True

        -- Caso (x==0) = False:

                False ⇒ (0 * evaluar r q) == 0
        {Bool} = True

{-
Paso inductivo:
Nuestra HI será P(p): (esRaiz r p ⇒ esRaiz r (Prod p q))

Por el tipo de dato, tenemos que ver 2 cosas:
        Caso recursivo P(Suma n m):
                ∀n::a. ∀m::a.
                P(Suma n m): (esRaiz r (Suma n m) ⇒ esRaiz r (Prod (Suma n m) q))
        Caso recursivo P(Prod n m):
                ∀n::a. ∀m::a.
                P(Prod n m): (esRaiz r (Prod n m) ⇒ esRaiz r (Prod (Prod n m) q))
-}     

-- Caso P(Suma n m):

        (esRaiz r (Suma n m) ⇒ esRaiz r (Prod (Suma n m) q))
{ER0} = (evaluar r (Suma n m)) == 0 ⇒ (evaluar r (Prod (Suma n m) q))) == 0
{E2}  = (evaluar r n + evaluar r m) == 0 ⇒ (evaluar r (Prod (Suma n m) q))) == 0
{E3}  = (evaluar r n + evaluar r m) == 0 ⇒ (evaluar r (Suma n m) * evaluar r q) == 0
{E2}  = (evaluar r n + evaluar r m)==0 ⇒ ((evaluar r n + evaluar r m)*evaluar r q)==0

-- Caso ((evaluar r n + evaluar r m) == 0):
         0 == 0 ⇒ (0 * evaluar r q) == 0
INT    = 0 == 0 ⇒ 0 == 0
2*Bool = True ⇒ True
Bool   = True

-- Caso ((evaluar r n + evaluar r m) != 0), llamamos
-- (evaluar r n + evaluar r m) = k, k!=0, luego:
       k == 0 ⇒ (k * evaluar r q) == 0
Bool = False ⇒ (k * evaluar r q) == 0
Bool = True

-- Caso P(Prod n m):

        (esRaiz r (Prod n m) ⇒ esRaiz r (Prod (Prod n m) q))
{ER0} = (evaluar r (Prod n m)) == 0 ⇒ (evaluar r (Prod (Prod n m) q)) == 0
{E3}  = (evaluar r (Prod n m)) == 0 ⇒ ((evaluar r (Prod n m)) * (evaluar r q))) == 0

-- Caso (evaluar r (Prod n m)) == 0:

       0 == 0 ⇒ (0 * (evaluar r q)) == 0
INT  = 0 == 0 ⇒ 0 == 0
Bool = True ⇒ True
Bool = True

-- Caso (evaluar r (Prod n m)) != 0,
-- Decimos que (evaluar r (Prod n m)) == k, k != 0

       k == 0 ⇒ (k * (evaluar r q)) == 0
Bool = False ⇒ (k * (evaluar r q)) == 0
Bool = True

```
QED

