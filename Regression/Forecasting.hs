module Forecasting.Regression where

import Data.List
import Data.Ord (comparing)

-- least-squares lineare regressie van /y/ tegen /x/ voor een collectie
-- (/x/, /y/) data, in de vorm (/b0/, /b1/, /r/)
-- regressie is /y/ =/b0/ + /b1/ * /x/ met de Pearson coefficient /r/
linearReg :: (Floating b) => [(b, b)] -> (b, b, b)
linearReg xys = let !xs = map fst xys -- lijst met alle x waarden
                    !ys = map snd xys -- lijst met alle y waarden
                    !n = fromIntegral $ length xys -- aantal items
                    !sX = sum xs -- som van de x waarden
                    !sY = sum ys -- som van de y waarden
                    !sXX = sum $ map (^ 2) xs -- som van de kwadraten van x
                    !sXY = sum $ map (uncurry (*)) xys  -- som van de vermenigvuldiging van elk (x, y) paar
                    !sYY = sum $ map (^ 2) ys -- som van de kwadraten van x
                    !alpha = (sY - beta * sX) / n -- alpha waarde b0
                    !beta = (n * sXY - sX * sY) / (n * sXX - sX * sX) -- slope
                    !r = (n * sXY - sX * sY) / (sqrt $ (n * sXX - sX^2) * (n * sYY - sY ^ 2)) -- pierson regressie
                  in (alpha, beta, r) -- geef b0 b1 en r terug
