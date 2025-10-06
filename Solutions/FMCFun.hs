{-# LANGUAGE GADTs #-}

module ExList where

import Prelude hiding
    ( (.) , ($)
    , flip , curry , uncurry
    , iterate
    )

-- use your mind to infer the types, don't cheat!

-- curry takes a "traditional" binary function
-- and returns its currified version
curry :: ((a, b) -> c) -> (a -> b -> c)
curry f a b = f (a, b) --Currificação

-- uncurry takes a currified function
-- and returns its "traditional" binary version
uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry f (a, b) = f a b --Descurrificação

-- flip takes a (currified) binary function
-- and returns one that behaves the same but takes its arguments in the opposite order
flip :: (a -> b -> c) -> (b -> a -> c)
flip f a b = f b a  --Inverte a ordem dos dois primeiros argumentos de uma função currificada

-- (.) takes two composable functions and returns their composition
(.) :: (a -> b) -> (b -> c) -> (a -> c)
(.) f g a = g (f a) --Composição de função (Direita-Esquerda)

-- (.>) is composition but in diagramatic notation (should be ; but Haskell forbids)
(.>) :: (b -> c) -> (a -> b) -> a -> c
(.>) = flip (.) --Composição de função (Esquerda-direita)

-- ($) takes a function and a suitable argument and applies the function to the argument
-- think: why would we ever want that?
($) :: (a -> b) -> a -> b
f $ a = f a --Aplicação de função

-- iterate: figure it out by its type
iterate :: (a -> a) -> a -> [a]
iterate f a = a : iterate f (f a) --Geração de lista infinita por iteração

-- orbit
orbit :: a -> (a -> a) -> [a]
orbit = flip iterate --Semelhante ao iterate, porém com a ordem dos dois primeiros argumentos invertida

