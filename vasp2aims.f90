!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Copyright 2013 Lee A. Burton
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!    This program is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    This program is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with this program.  If not, see <http://www.gnu.org/licenses/>.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

PROGRAM vasp2aims  ! VERSION 4

IMPLICIT NONE  !means all variables are of a defined length and format

REAL :: cellmult,a,b,c,d,e,f,g,h,j,o,p,q,amult,bmult,cmult,dmult,emult,fmult,gmult,hmult,jmult
REAL, DIMENSION (:,:), ALLOCATABLE :: coords
CHARACTER(LEN=80) :: line, line2, linetemp, linetemp1, name
CHARACTER(LEN=9) :: type, coordtype
CHARACTER(3), DIMENSION (:), ALLOCATABLE :: elems
INTEGER, DIMENSION (:), ALLOCATABLE :: atoms
INTEGER :: n, i, ij, OPEN_ERROR, DEALLOC_ERROR, ALLOC_ERROR, bob, blop, numscan, lentrim 

OPEN(1,FILE='POSCAR',STATUS='old',IOSTAT=OPEN_ERROR)

IF (OPEN_ERROR.NE.0) THEN
        STOP "Error: POSCAR does not exist"
    END IF

	READ(1,*)
	READ(1,*) cellmult
	READ(1,*) a,b,c
	READ(1,*) d,e,f
	READ(1,*) g,h,j
        READ(1,'(A80)') line	

linetemp=ADJUSTL(line)
lentrim=LEN_TRIM(line)

numscan=SCAN(linetemp," ")
i=0

DO 
        i=i+1
        numscan=SCAN(linetemp," ")
                
		IF (numscan==1 ) EXIT

        name=linetemp(i:(numscan-1))
        linetemp1=linetemp(numscan:lentrim)
        linetemp=linetemp1
        linetemp=ADJUSTL(linetemp)
        lentrim=LEN_TRIM(linetemp)
END DO
n=i-1

ALLOCATE(elems(n),STAT=ALLOC_ERROR)

		IF (ALLOC_ERROR.NE.0) THEN
			STOP "Error during element allocation"
		END IF

READ(line,*) elems

	READ(1,'(A80)') line2
ALLOCATE(atoms(n),STAT=ALLOC_ERROR)

		IF (ALLOC_ERROR.NE.0) THEN
			STOP "Error during atom number allocation"
		END IF

READ(line2,*) atoms

READ(1,*) coordtype

		IF (coordtype.EQ."Direct") THEN 
			type="atom_frac"
			ELSE
		 	type="atom"
		END IF



OPEN(2,FILE='geometry.in',STATUS='new',IOSTAT=OPEN_ERROR)

                IF (OPEN_ERROR.NE.0) THEN
                        STOP "Error creating geometry.in"
                END IF

amult=a*cellmult
bmult=b*cellmult
cmult=c*cellmult
dmult=d*cellmult
emult=e*cellmult
fmult=f*cellmult
gmult=g*cellmult
hmult=h*cellmult
jmult=j*cellmult


       WRITE(2,'(A15, 3F14.10)') 'lattice_vector ', amult, bmult, cmult
       WRITE(2,'(A15, 3F14.10)') 'lattice_vector ', dmult, emult, fmult
       WRITE(2,'(A15, 3F14.10)') 'lattice_vector ', gmult, hmult, jmult 

DO i=1,n 
	ij=atoms(i)
 		DO blop=1,ij 
			READ(1,*)o,p,q
			WRITE(2,'(A,3F13.9,1x,A)') type,o,p,q, elems(i)
		END DO
END DO


CLOSE(1)
CLOSE(2)

DEALLOCATE(elems, STAT=DEALLOC_ERROR)
                IF (DEALLOC_ERROR.NE.0) THEN
                        STOP "Error during element de-allocation"
                END IF
DEALLOCATE(atoms, STAT=DEALLOC_ERROR)
                IF (DEALLOC_ERROR.NE.0) THEN
                        STOP "Error during element de-allocation"
                END IF

END PROGRAM
