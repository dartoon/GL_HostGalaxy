C  This program takes a list of points that are vertices of a polygon
C  and outputs all the points within that polygon.  This is useful to
C  mark bad regions due to dustlane, jets, HII regions, or other stuff,
C  when using the 'ellipse' task.
C
C  Chien Peng

	program fillpoly

	IMPLICIT NONE

	real 		vrx(1025), vry(1025)
	integer		i, nv, nbd, npts, vx(1025), vy(1025), 
     +			x(500000), y(500000), xout(500000), yout(500000),
     +			vtex(500000)
	character*30	infile, outfile

1	format ( a, $ )

	call getarg (1, infile)
	call getarg (2, outfile)

	if (infile .eq. '' .or. outfile .eq. '') then
	    write (*, 1) "File containing vertex points, output file: "
	    read (*, *) infile, outfile
	endif

	open ( unit=10, file=infile, status="OLD" )

	do i = 1, 1025
99		read ( 10, *, end=101, err=99 ) vrx(i), vry(i)
		vx(i) = nint(vrx(i))
		vy(i) = nint(vry(i))
	enddo
101	close (10)
	nv = i-1

	open ( unit=20, file="boundary" )
	call define_boundary ( vx, vy, nv, x, y, nbd, vtex )
	do i = 1, nbd
		write(20,*) x(i), y(i), vtex(i)
	enddo
	close (20)

	call fill ( x, y, nbd, xout, yout, npts, vtex )

	open ( unit=30, file=outfile, status="unknown", access="append" )
	do i = 1, npts
		write (30, *) xout(i), yout(i)
	enddo
	close (30)
	end

C =============================================================================

	subroutine fill ( x, y, nbd, xout, yout, npt, vtex )

	IMPLICIT NONE

	integer x(500000), y(500000), nbd, xout(500000), yout(500000), i,
     +		j, k, n, npt, suby(1025), vtex(500000), subvtex(1025), 
     +		dummy(1025), intvtex, mode


	call shellsort ( nbd, x, y, vtex )

	npt = 0
	i = 1
	do while ( i .le. nbd )
		n = 0
		intvtex = 0

		do while ( x(i+n) .eq. x(i) )
			n = n + 1
			suby(n) = y(i+n-1)
			subvtex(n) = vtex(i+n-1)
C Set intercept vertex flag.
			if ( subvtex(n) .eq. 1 .or. subvtex(n) .eq. -1 ) 
     +				intvtex = 1
		enddo
		
		call shellsort (n, suby, subvtex, dummy)

C If only 1 point (n=1), must be vertex....

		if ( n .eq. 1 ) then 
			npt = npt + 1
			xout(npt) = x(i)
			yout(npt) = y(i)
		endif

C Normal... Doesn't intercept vertex.

		j = 1
		if ( n .gt. 1 .and. intvtex .eq. 0 ) then
			do while ( j .le. n )
				do k = suby(j), suby(j+1)
					npt = npt + 1
					xout(npt) = x(i)
					yout(npt) = k
				enddo
				j = j + 2
			enddo
		endif

C If intercept vertex...

		if ( n .gt. 1 .and. intvtex .eq. 1 ) then

C mode = 1   previously in fill state
C mode = 0   previously not in fill state

			mode = 0
			j = 1

			do while ( j .le. n )

C Switch to a different fill mode if vertex shape is \/ or /\ or __/ or \__ or
C  __    __          /     \
C /   or   \  or    |   or  |  , i.e. vertex type is -1.
C                  /         \

				if (subvtex(j) .eq. -1 .and. mode .eq. 0) then
					do k = suby(j), suby(j+1)
						npt = npt + 1
						xout(npt) = x(i)
						yout(npt) = k
					enddo

C Watch out how far to jump.  If next point is not vertex, then jump by
C 2 points, otherwise go to it.

					if ( subvtex(j+1) .eq. 9 ) then
						j = j + 2
						mode = 0
					else if ( subvtex(j+1) .ne. 0 ) then
						j = j + 1
						mode = 1
					else
						j = j + 1
					endif
				else if (subvtex(j) .eq. -1 .and. 
     +							mode .eq. 1) then
					if (subvtex(j+1) .ne. 0 ) 
     +						mode = 0
					npt = npt + 1
					xout(npt) = x(i)
					yout(npt) = suby(j)
					j = j + 1

C                               \      /
C If vertex shape is < or > or   | or |   continue same mode as before, i.e.
C                               /      \
C vertex type is +1.

				else if (subvtex(j) .eq. 1 .and. mode. eq. 1) then
					do k = suby(j), suby(j+1)
						npt = npt + 1
						xout(npt) = x(i)
						yout(npt) = k
					enddo
					if ( subvtex(j+1) .eq. 9 ) then
						j = j + 2
						mode = 0
					else if ( subvtex(j+1) .ne. 0 ) then
						j = j + 1
						mode = 1
					else
						j = j + 1
					endif
				else if (subvtex(j) .eq. 1 .and. mode .eq. 0) then
					npt = npt + 1
					xout(npt) = x(i)
					yout(npt) = suby(j)
					j = j + 1
				else if ( subvtex(j) .eq. 9 ) then
C Not at vertex....
					do k = suby(j), suby(j+1)
						npt = npt + 1
						xout(npt) = x(i)
						yout(npt) = k
					enddo
					if ( subvtex(j+1) .eq. 9 ) then
						j = j + 2
						mode = 0
					else if ( subvtex(j+1) .ne. 0 ) then
						j = j + 1
						mode = 1
					else
						j = j + 1
					endif
				else if ( subvtex(j) .eq. 0 ) then

C At vertical boundary....  Keep mode the same.

					npt = npt + 1
					xout(npt) = x(i)
					yout(npt) = suby(j)
					j = j + 1
				endif
			enddo
		endif
		i = i + n
	enddo
	end

C =============================================================================
C  This subroutine linearly interpolates to find all the boundary points

	subroutine define_boundary ( vx, vy, nv, x, y, pt, vtex )

	IMPLICIT NONE

	integer	vx(1025), vy(1025), x(500000), y(500000), nv, pt, sign,
     +		prevx, nextvx, nextvy, step, i, j, vtex(500000), k, nextx,
     +		exit, tempx, tempy, tempi
	real	m, b


        tempx = 1e6
        tempy = 1e6

        do i = 1, nv
                if ( vx(i) .lt. tempx .or.
     +               (vx(i) .eq. tempx .and. vy(i) .lt. tempy) ) then
                        tempi = i
                        tempx = vx(i)
                        tempy = vy(i)
                endif
        enddo
        do i = 1, tempi - 1
                tempx = vx(1)
                tempy = vy(1)
                do j = 1, nv - 1
                        vx(j) = vx(j+1)
                        vy(j) = vy(j+1)
                enddo
                vx(nv) = tempx
                vy(nv) = tempy
        enddo


C                                                  /     \
C  vtex(i) = 1 when vertex is of shape  < or > or |   or  |
C                                                  \     /
C
C                                                      /     \
C  vtex(i) = -1 when vertex is of shape  \_ or _/ or  |   or  |
C                                                    /         \
C
C  vtex(i) = 9 if at boundary rather than vertex and or vertical boundary.
C  vtex(i) = 0 if at vertical boundary

	pt = 0
	i = 0
	exit = 0
	do while ( i .lt. nv .and. exit .eq. 0 )
		i = i + 1
		if ( i .ne. nv .and. i .ne. 1 ) then
			prevx = vx(i-1)
			nextvx = vx(i+1)
			nextvy = vy(i+1)
		else if ( i .eq. 1 ) then
			prevx = vx(nv)
			nextvx = vx(2)
			nextvy = vy(2)
		else if ( i .eq. nv ) then
			nextvx = vx(1)
			nextvy = vy(1)
			prevx = vx(nv-1)
		endif

		if ( vx(i) .gt. nextvx .and. vx(i) .gt. prevx ) then
			sign = 1
		else if ( vx(i) .lt. nextvx .and. vx(i) .lt. prevx ) then
			sign = 1
		else if ( vx(i) .eq. nextvx .and. vx(i) .gt. prevx ) then
			k = i
			do while (k .lt. nv .and. vx(k+1) .eq. vx(k))
				k = k + 1
			enddo
			if ( k .eq. nv .and. vx(1) .eq. vx(nv) ) then
				k = 0
				do while ( vx(k+1) .eq. vx(nv) )
					k = k + 1
				enddo
				exit = 1
			endif
			nextx = vx(k+1)
			nextvy = vy(k)

			if ( nextx .gt. vx(k) ) then
				sign = -1
			else if ( nextx .lt. vx(k) ) then
				sign = 1
			endif
		else if ( vx(i) .eq. nextvx .and. vx(i) .lt. prevx ) then
			k = i
			do while (k .lt. nv .and. vx(k+1) .eq. vx(k))
				k = k + 1
			enddo
			if ( k .eq. nv .and. vx(1) .eq. vx(nv) ) then
				k = 0
				do while ( vx(k+1) .eq. vx(nv) )
					k = k + 1
				enddo
				exit = 1
			endif
			nextx = vx(k+1)
			nextvy = vy(k)

			if ( nextx .gt. vx(k) ) then
				sign = 1
			else if ( nextx .lt. vx(k) ) then
				sign = -1
			endif
		else if ( vx(i) .gt. nextvx .and. vx(i) .lt. prevx ) then
			sign = -1
		else if ( vx(i) .lt. nextvx .and. vx(i) .gt. prevx ) then
			sign = -1
		endif

		if ( nextvx .gt. vx(i) ) then
			step = 1
		else if ( nextvx .lt. vx(i) )then
			step = -1
		else if ( nextvy .gt. vy(i) ) then
			step = 1
		else
			step = -1
		endif		

		if ( nextvx .ne. vx(i) )then
			m = ( real(nextvy - vy(i)) ) / ( real(nextvx - vx(i)) )
			b = real(vy(i)) - m * real(vx(i))
			do j = vx(i), nextvx, step
				pt = pt + 1
				x(pt) = j
				y(pt)= nint(m * real(x(pt)) + b)
				if ( j .ne. vx(i) .and. j .ne. nextvx ) then
     					vtex(pt) =  9
				else
					vtex(pt) = sign
				endif
			enddo
		else 
			do j = vy(i), nextvy, step
				pt = pt + 1
				x(pt) = vx(i)
				y(pt) = j
				if ( j .eq. vy(i) .or. j .eq. nextvy ) then
     					vtex(pt) = sign
				else
					vtex(pt) = 0
				endif
			enddo
			i = k - 1
		endif

		if ( exit .eq. 1 .and. k .eq. 1 ) then
			vtex(1) = sign
		else if ( exit .eq. 1 ) then
			vtex(1) = 0
		endif

C vertex points are duplicated...
		pt = pt - 1

	enddo

	end


C ==============================================================================
C
C SORT THE X AND Y ARRAYS - from Numerical recipes Shell sort:
C

      SUBROUTINE shellsort(n,a,b,c)
      INTEGER n
      INTEGER a(n), b(n), c(n)
      INTEGER i,j,inc
      REAL v, w, x
      inc=1
1     inc=3*inc+1
      if(inc.le.n)goto 1
2     continue
        inc=inc/3
        do 11 i=inc+1,n
          v=a(i)
	  w=b(i)
	  x=c(i)
          j=i
3         if(a(j-inc).gt.v)then
            a(j)=a(j-inc)
	    b(j)=b(j-inc)
	    c(j)=c(j-inc)
            j=j-inc
            if(j.le.inc)goto 4
          goto 3
          endif
4         a(j)=v
	  b(j)=w
	  c(j)=x
11      continue
      if(inc.gt.1)goto 2
      return
      END

