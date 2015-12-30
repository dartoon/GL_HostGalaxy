#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[2])
{

    FILE *input;
    char polygon[2];
    float x, y;

    if (argc < 2) {
        printf ("\n Usage: ds9poly <polygon_file> \n\n");
        exit(1);
    }

    input = fopen (argv[1], "r");
    if (input == NULL) {
	printf ("\nError:  Can't find the input file named `%s'.\n\n", argv[1]);
	exit(1);
    };

    while ( fscanf (input, "%*[^(]"));

    fscanf (input, "%1s", polygon);

    while ( fscanf (input, " %f, %f,", &x, &y) != EOF && 
			!fscanf (input, ")") )
         printf (" %f %f \n", x, y);

    fclose (input);
}

