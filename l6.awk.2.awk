#!/usr/bin/awk -f

BEGIN { 

	FS = "\n"
	RS = ""
}


{

	for (i=1; i <= NF; i++) { 

		printf( "%s\t",  $i)
	}

	printf( "\n") 


}
