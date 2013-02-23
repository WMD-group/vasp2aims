vasp2aims
=========

A Fortran code to convert the structure input of VASP (POSCAR) to the format of FHI-AIMS (geometry.in).

Files
------------
- vasp2aims.f90 (Fortran90 code)
- vasp2aims (mac compiled binary)

Usage
------------
Execute binary with no arguments. vasp2aims looks for an input file named "POSCAR" in the current directory, and creates a file named "geometry.in".