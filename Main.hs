module Main where

import Forecasting.Regression
import System.IO
import Data.List

main  = do
  file <- readFile "uni.txt"
  let matrix = map words $ lines file
  let headerLess = drop 1 matrix
  let highGPA = rFloats $ map head headerLess
  let uniGPA = rFloats $ map last headerLess
  let gpa = zip highGPA uniGPA
  let filename = "regressie.txt"
  writeFile filename $ delete '(' . delete ')' . replaceComma $show (linearReg gpa)


rFloats :: [String] -> [Float]
rFloats = map (read:: String -> Float)

replaceComma = let
                replaceComma ',' = '\t'
                replaceComma c = c
               in map replaceComma

