{-# LANGUAGE GADTs #-}

module FMCList where

import Prelude
    ( Char , String , Int , Integer , Double , Float , Bool(..)
    , Num(..) , Integral(..) , Enum(..) , Ord(..) , Eq(..)
    , not , (&&) , (||)
    , (.) , ($)
    , flip , curry , uncurry
    , otherwise , error , undefined
    )
import qualified Prelude   as P
import qualified Data.List as L
import qualified Data.Char as C

{- import qualified ... as ... ?

To use a function from a qualified import
you need to prefix its name with its alias and a dot:
P.head   C.toUpper   etc.

I import these for you to test the original functions on ghci:

ghci> :t C.toUpper
C.toUpper :: Char -> Char

You MUST NOT use ANY of these in your code

-}


{- Our lists vs Haskell lists

Our definition:

data List a where
  Nil  :: List a
  Cons :: a -> List a -> List a

Here we use Haskell's built-in lists and associated syntactic sugar.
It is as if it was defined like this:

    data [a] = [] | (x : xs)

or like this:

    data [a] where
      []  :: [a]
      (:) :: a -> [a] -> [a]

write [a]       for our List a
write []        for our List
write []        for our Nil
write (x : xs)  for our Cons x xs
write [u,v]     for our u `Cons` (v `Cons` Nil)

-}

head :: [a] -> a
head [] = undefined --Lista vazia não possui head
head (x : _) = x

tail :: [a] -> [a]
tail [] = undefined --Lista vazia não possui tail
tail (_ : xs) = xs

null :: [a] -> Bool
null [] = True
null (_ : _) = False

length :: Integral i => [a] -> i
length [] = 0
length (_ : xs) = length xs + 1

sum :: Num a => [a] -> a
sum [] = 0
sum (x : xs) = sum xs + x

product :: Num a => [a] -> a
product [] = 0
product (x : xs) = product xs * x

reverse :: [a] -> [a]
reverse []= []
reverse (x : xs) = reverse xs ++ [x] 

--concatenação
(++) :: [a] -> [a] -> [a]
(++) [] xs = xs
(++) (x : xs) ys = x : (xs ++ ys)

-- right-associative for performance!
-- (what?!)
infixr 5 ++

-- (snoc is cons written backwards)
--adiciona um elemento ao final de uma lista
snoc :: a -> [a] -> [a]
snoc x [] = [x]
snoc y (x : xs) = x : snoc y xs

(<:) :: [a] -> a -> [a]
(<:) = flip snoc

-- different implementation of (++)
(+++) :: [a] -> [a] -> [a]
xs +++ []     = xs
xs +++ [y]    = xs <: y
xs +++ (y:ys) = (xs +++ [y]) +++ ys

-- left-associative for performance!
-- (hmm?!)
infixl 5 +++

minimum :: Ord a => [a] -> a
minimum [] = undefined
minimum [x] = x
minimum (x : xs) = min x (minimum xs)

maximum :: Ord a => [a] -> a
maximum [] = undefined
maximum [x] = x
maximum (x : xs) = max x (maximum xs)

--retorna os primeiros n elementos de uma lista
take :: Int -> [a] -> [a]
take _ [] = []
take 0 _ = []
take n (x:xs) = x : take (n-1) xs

--remove os primeiros n elementos de uma lista
drop :: Int -> [a] -> [a]
drop _ [] = []
drop 0 xs = xs 
drop n (x : xs) = drop (n - 1) xs

--retorna o prefixo mais longo da lista os quais satisfazem certa condição
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [] = []
takeWhile p (x : xs)
    | p x       = x : takeWhile p xs
    | otherwise = [] 

--remove o prefixo mais longo da lista os quais satisfazem certa condição
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ [] = []
dropWhile p (x : xs)
    | p x       = dropWhile p xs
    | otherwise = x:xs

--retorna uma lista de todas as tails possíveis da lista de entrada
tails :: [a] -> [[a]]
tails [] = [[]]
tails (x : xs) = (x : xs) : tails xs

--retorna a lista com o ultimo elemento removido
init :: [a] -> [a]
init [] = undefined
init [x] = []
init (x : xs) = x : init xs

--retorna uma lista de todos os prefixos possiveis da lista de entrada
inits :: [a] -> [[a]]
inits [] = [[]]
inits xs = xs : inits (init xs)

-- subsequences

-- any
-- all

-- and
-- or

-- concat

-- elem using the funciton 'any' above

-- elem': same as elem but elementary definition
-- (without using other functions except (==))

-- (!!)

--constroe uma nova lista com apenas os itens que satisfazem uma certa condição
filter :: (a -> Bool) -> [a] -> [a] 
filter _ [] = []
filter f (x : xs)
  | f x = x : filter f xs
  | otherwise = filter f xs

--aplica uma função de transformação a cada elemento de uma lista e retorna uma nova lista com os resultados dessas transformações
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x : xs) = f x : map f xs

-- cycle
-- repeat
-- replicate

-- isPrefixOf
-- isInfixOf
-- isSuffixOf

-- zip
-- zipWith

-- intercalate
-- nub

-- splitAt
-- what is the problem with the following?:
-- splitAt n xs  =  (take n xs, drop n xs)

-- break

-- lines
-- words
-- unlines
-- unwords

-- transpose

-- checks if the letters of a phrase form a palindrome (see below for examples)
palindrome :: String -> Bool
palindrome = undefined

{-

Examples of palindromes:

"Madam, I'm Adam"
"Step on no pets."
"Mr. Owl ate my metal worm."
"Was it a car or a cat I saw?"
"Doc, note I dissent.  A fast never prevents a fatness.  I diet on cod."

-}

