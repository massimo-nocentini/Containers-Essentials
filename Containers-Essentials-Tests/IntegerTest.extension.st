Extension { #name : #IntegerTest }

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testAsStringAZaz [

	| n |
	self
		assert: ((0 to: 104) collect: [ :each | each asStringAZaz ])
		equals:
			#( 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'A' 'B' 'C' 'D' 'E' 'F'
			   'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V'
			   'W' 'X' 'Y' 'Z' 'u' 'v' 'w' 'x' 'y' 'z' 'a' 'b' 'c' 'd' 'e' 'f'
			   'g' 'h' 'i' 'j' 'lk' 'll' 'lm' 'ln' 'lo' 'lp' 'lq' 'lr' 'ls'
			   'lt' 'lA' 'lB' 'lC' 'lD' 'lE' 'lF' 'lG' 'lH' 'lI' 'lJ' 'lK' 'lL'
			   'lM' 'lN' 'lO' 'lP' 'lQ' 'lR' 'lS' 'lT' 'lU' 'lV' 'lW' 'lX' 'lY'
			   'lZ' 'lu' 'lv' 'lw' 'lx' 'ly' 'lz' 'la' 'lb' 'lc' 'ld' 'le' 'lf'
			   'lg' 'lh' 'li' 'lj' 'mk' ).

	"Ensure #asStringAZaz is a bijection: for the sake of clarity,
	 to each integer corresponds an unique AZaz representation."
	n := 10000.
	self
		assert:
		((1 to: n) collect: [ :each | each asStringAZaz ] as: Set) size
		equals: n
]
