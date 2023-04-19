LOOP_NUM=3
export CUDA_VISIBLE_DEVICES=1
MOL=minip.altE
LOG=runner.log
ENERGY_LOG=energy.log

echo "Starting..." > $ENERGY_LOG
echo "Begin" > $LOG
for i in {0..2}
do
    echo "Starting iteration $i..." >> $LOG
    #Step 1: Heat command
    echo "Step 1 - Heating" >> $LOG
    RST=prod.rst
    if [ $i == 0 ]
    then
        RST=min.rst
    fi
    pmemd.cuda -O -i heat.in -p $MOL.prmtop -c $RST -r heat.rst -o heat.out -x heat.mdcrd
    echo "!!!Step 1 on iteration $i" >> $ENERGY_LOG
    cat heat.out >> $ENERGY_LOG

    #Step 2 - "Mild annealing"
    echo "Step 2 - Mild Annealing" >> $LOG
    pmemd.cuda -O -i equil.in -p $MOL.prmtop -c  heat.rst  -r equil.rst -o equil.out -x equil.mdcrd
    echo "!!!Step 2 on iteration $i" >> $ENERGY_LOG
    cat equil.out >> $ENERGY_LOG

    #Step 3 - "Strong" Annealing
    echo "Step 3 - Strong Annealing" >> $LOG
    pmemd.cuda -O -i annealing.in -o annealing.out -x annealing.mdcrd -p $MOL.prmtop -c equil.rst  -r annealing.rst
    echo "!!!Step 3 on iteration $i" >> $ENERGY_LOG
    cat annealing.out >> $ENERGY_LOG

    #Step 4 - "Mild" Annealing again 
    echo "Step 4 - Mild Annealing Again" >> $LOG
    pmemd.cuda -O -i prod.in -p $MOL.prmtop -c  annealing.rst  -r prod.rst -o prod.out -x prod.mdcrd
    echo "!!!Step 4 on iteration $i" >> $ENERGY_LOG
    cat prod.out >> $ENERGY_LOG

done

echo "Done!" >> $LOG