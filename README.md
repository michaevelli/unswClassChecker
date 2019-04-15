## UNSW Class Capacity Checker

Simple web scraper that draws data from classutil.unsw.edu.au  
Prints out class details for a specified course

## Usage

<pre>
$ <b>perl classcheck.pl COMP1000<b>
Course: COMP1000
=== Term 1 ===
Class does not run in Term 1
=== Term 2 ===
CRS	CR01	1099	116/123	94%
LAB	M11A	7925	8/25	32%
LAB	M11B	7926	4/24	17%
LAB	M13A	7927	6/24	25%
LAB	M13B	7928	6/25	24%
LAB	M15A	7929	5/25	20%
LAB	T09A	7930	11/24	46%
LAB	T09B	7931	10/26	38%
LAB	T13A	7932	24/24	100%
LEC	1UGA	7924	57/180	32%
LEC	WEB1	7933	17/17	100%
=== Term 3 ===
Class does not run in Term 3
$ <b>perl classcheck.pl COMP1000 -t1 -t3<b>
Course: COMP1000
=== Term 1 ===
Class does not run in Term 1
=== Term 3 ===
Class does not run in Term 3
$ <b>perl classcheck.pl COMP1000 -t2 -cCR01 -cM11B -c7924</b>
Course: COMP1000
=== Term 2 ===
CRS	CR01	1099	116/123	94%
LAB	M11B	7926	4/24	17%
LEC	1UGA	7924	57/180	32%
</pre>

## Installation

It's a perl script. Just run it. Alternatively put it in your bin folder

## Contributing

Do as you wish, I suppose

## License

MIT