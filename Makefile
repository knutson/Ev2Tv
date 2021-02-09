#### GNU compiler
FC = gfortran
FOPTS = -g -fPIC -D_GNU_SOURCE -O0 -Wall -Wstrict-aliasing  -fstrict-aliasing -ffixed-line-length-132

all:
	$(FC) $(FOPTS) main.f90

clean:
	rm -f a.out 
