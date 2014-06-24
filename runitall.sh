./forecasting $1 $2
gnuplot -e "filename='$2';column1=$3;column2=$4;column3=$5;labelX='$6';labelY='$7'" script.gnuplot
