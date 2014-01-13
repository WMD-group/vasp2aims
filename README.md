vasp2aims
=========

A Fortran code to convert the structure input of VASP (POSCAR) to the format of FHI-AIMS (geometry.in).

Files
------------
- vasp2aims.f90 (Fortran90 code)
- vasp2aims (mac compiled binary)

Usage
------------
Execute binary with no arguments. 
*vasp2aims* looks for an input file named "POSCAR" in the current directory, 
and creates a file named "geometry.in".

Disclaimer
----------

This program is not affiliated with *FHI-aims* or *VASP*. 
The program is made available under the GNU General Public License; 
you are free to use and/or modify the code, but do so at your own risk.
