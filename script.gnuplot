set term postscript
set output '| ps2pdf - output.pdf'
set ytics 0.5

set mytics 0.5
set key top left
set title "GPA regression"
set xlabel "HighSchool GPA"
set ylabel "University GPA"
b0 = "`head regressie.txt | awk '{print $1}'`"
b1 = "`head regressie.txt | awk '{print $2}'`"
r  = "`head regressie.txt | awk '{print $3}'`"
y(x) = b0 + b1 * x
plot "uni.dat" using 1:5 title "gpa", y(x) lt 1 linecolor rgb "red" title "regressie"
