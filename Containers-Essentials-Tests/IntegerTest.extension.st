Extension { #name : #IntegerTest }

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testAsStringAZaz [

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
	10000 in: [ :n | 
		self
			assert:
			((1 to: n) collect: [ :each | each asStringAZaz ] as: Set) size
			equals: n ]
]

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testAsStringaz [

	self
		assert: ((0 to: 104) collect: [ :each | each asStringaz ])
		equals:
			#( 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'a' 'b' 'c' 'd' 'e' 'f'
			   'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'rq' 'rr' 'rs' 'rt' 'ru'
			   'rv' 'rw' 'rx' 'ry' 'rz' 'ra' 'rb' 'rc' 'rd' 're' 'rf' 'rg' 'rh'
			   'ri' 'rj' 'rk' 'rl' 'rm' 'rn' 'ro' 'rp' 'sq' 'sr' 'ss' 'st' 'su'
			   'sv' 'sw' 'sx' 'sy' 'sz' 'sa' 'sb' 'sc' 'sd' 'se' 'sf' 'sg' 'sh'
			   'si' 'sj' 'sk' 'sl' 'sm' 'sn' 'so' 'sp' 'tq' 'tr' 'ts' 'tt' 'tu'
			   'tv' 'tw' 'tx' 'ty' 'tz' 'ta' 'tb' 'tc' 'td' 'te' 'tf' 'tg' 'th'
			   'ti' 'tj' 'tk' 'tl' 'tm' 'tn' 'to' 'tp' 'uq' ).

	"Ensure #asStringAZaz is a bijection: for the sake of clarity,
	 to each integer corresponds an unique AZaz representation."
	10000 in: [ :n | 
		self
			assert:
			((1 to: n) collect: [ :each | each asStringAZaz ] as: Set) size
			equals: n ]
]

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testBitAverage [

	| s n m slowBenchResult quickBenchResult seconds |
	s := 2.

	self timeLimit: (s * 2 + 1) seconds.

	n := 38299527986758693756807879086754976930654.
	m := 57483879867596837956739087695867359769587.

	seconds := s seconds.

	quickBenchResult := [ n bitAverage: m ] benchFor: seconds.
	slowBenchResult := [ (n + m / 2) asInteger ] benchFor: seconds.

	self
		assert: (n bitAverage: m) equals: (n + m / 2) asInteger;
		assert: slowBenchResult iterations < quickBenchResult iterations
]

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testBitToggleDo [

	| n m |
	n := 38299527986758693756807879086754976930654.
	m := 57483879867596837956739087695867359769587.

	n bitToggle: m do: [ :toggle | 
		self
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m ]
]

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testBitToggleDo1 [

	| n m |
	n := 1.
	m := 0.

	n bitToggle: m do: [ :toggle | 
		self
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m;
			assert: toggle value equals: n;
			assert: toggle value equals: m ]
]

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testShiftOfNegativeOne [

	| a |
	a := -1.

	self
		assert: a >> 1 equals: -1;
		assert: a // 2 equals: -1
]
