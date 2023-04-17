RAW_STORAGE=out
FORMATTED_STORAGE=final.csv
cat $1 | grep "TIME\|EPtot\|NSTEP" > $RAW_STORAGE
echo "step,time,temp,EPtot" > $FORMATTED_STORAGE
cat $RAW_STORAGE | awk -f parse.awk >> $FORMATTED_STORAGE
python3 plot.py -i:$FORMATTED_STORAGE -t:Results