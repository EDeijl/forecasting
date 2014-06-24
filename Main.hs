{-# LANGUAGE BangPatterns #-}

module Main where

import Forecasting.Regression
import System.IO
import Data.List
import System.Environment

main  = do
  args <- getArgs
  let inputFile = head args
  let outputFile = last args
  file <- readFile $ inputFile
  let matrix = map words $ lines file
  let headerLess = drop 1 matrix
  let columnX = rFloats $ map head headerLess
  let columnY = rFloats $ map last headerLess
  let dataSet = zip columnX columnY
  let filename = "regressie.txt"
  writeFile filename $ delete '(' . delete ')' . replaceComma $show (linearReg dataSet)
  let smooth = smoothing (mean $ take 12 columnY) 0.732 columnY
  let forecast = drop 1 $ smooth
  let withSmoothing = zip3 columnX columnY forecast
  let withoutBracets = map (delete '(' . delete ')') (map show withSmoothing)
  let withTabs = map replaceComma withoutBracets
  let withFileEnd = map (++ "\n") withTabs
  writeFile outputFile "t\tDemand\tlevel estimate\n"
  mapM_ (\x -> appendFile outputFile x) withFileEnd
  let dSet = zip columnY smooth
  let errors = drop 1 $ scanl (\a (x, y) -> x - y) 0 dSet
  let squaredErrors = sumOfSquares errors
  let sError = standardError squaredErrors errors


rFloats :: [String] -> [Float]
rFloats = map (read:: String -> Float)

replaceComma = let
                replaceComma ',' = '\t'
                replaceComma c = c
               in map replaceComma

