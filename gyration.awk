#!/usr/bin/awk -f

#A script to compute average radius (radius of gyration) of a protein
# from its PDB coordinate file

BEGIN {
	natom=0 
	Xcm = 0
	Ycm = 0
	Zcm = 0
	Rg = 0



} 

{

	if($1 == "ATOM" && $5 <= 20000) {
			natom++
			x[natom] = $6
			y[natom] = $7
			z[natom] = $8
	}

}

END { 

	for(i = 1; i <= natom; ++i){

		Xcm+= x[i]/natom
		Ycm+= y[i]/natom
		Zcm+= z[i]/natom
	}

	for(i = 1; i <= natom; i++){

		xx = (x[i] - Xcm)*(x[i] - Xcm)
		yy = (y[i] - Ycm)*(y[i] - Ycm)
		zz = (z[i] - Zcm)*(z[i] - Zcm)

#		if( xx +  yy + zz < 5.0 ) print i 

		Rg+= xx + yy + zz 
	}

		Rg = sqrt(Rg/natom)

	print  "number of atoms = "  natom 
	print "Xcm, Ycm, Zcm = "  Xcm " " Ycm " " Zcm 
        print "Radius of the protein = " Rg

}
	  


