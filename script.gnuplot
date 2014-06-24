set term postscript
set output '| ps2pdf - output.pdf'

set key top left

set xlabel labelX
set ylabel labelY
b0 = "`head regressie.txt | awk '{print $1}'`"
b1 = "`head regressie.txt | awk '{print $2}'`"
r  = "`head regressie.txt | awk '{print $3}'`"
y(x) = b0 + b1 * x
plot filename using column1:column2 title "real" , y(x) lt 1 linecolor rgb "red" title "regressie", filename using column1:column3 lt 1 linecolor rgb "blue" title "forecast"
