Extension { #name : 'IntegerTest' }

{ #category : '*Containers-Essentials-Tests' }
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

{ #category : '*Containers-Essentials-Tests' }
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

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testBitAverage [

	| s n m slowBenchResult quickBenchResult seconds |
	s := 2.

	self timeLimit: (s * 2 + 1) seconds.

	n := 38299527986758693756807879086754976930654.
	m := 57483879867596837956739087695867359769587.

	seconds := s seconds.

	quickBenchResult := [ n bitAverage: m ] benchFor: seconds.
	slowBenchResult := [ (n + m / 2) asInteger ] benchFor: seconds.

	self assert: (n bitAverage: m) equals: (n + m / 2) asInteger.

	"For the sake of clarity, a run yields: 730482 < 3673262"
	self assert: slowBenchResult iterations < quickBenchResult iterations
]

{ #category : '*Containers-Essentials-Tests' }
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

{ #category : '*Containers-Essentials-Tests' }
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

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testNextEven [

	self
		assert: -2 nextEven equals: 0;
		assert: -1 nextEven equals: 0;
		assert: 0 nextEven equals: 2;
		assert: 1 nextEven equals: 2;
		assert: 2 nextEven equals: 4
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testNextEvenOrSelf [

	self
		assert: -2 nextEvenOrSelf equals: -2;
		assert: -1 nextEvenOrSelf equals: 0;
		assert: 0 nextEvenOrSelf equals: 0;
		assert: 1 nextEvenOrSelf equals: 2;
		assert: 2 nextEvenOrSelf equals: 2
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testNextOdd [

	self
		assert: -2 nextOdd equals: -1;
		assert: -1 nextOdd equals: 1;
		assert: 0 nextOdd equals: 1;
		assert: 1 nextOdd equals: 3;
		assert: 2 nextOdd equals: 3
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testNextOddOrSelf [

	self
		assert: -2 nextOddOrSelf equals: -1;
		assert: -1 nextOddOrSelf equals: -1;
		assert: 0 nextOddOrSelf equals: 1;
		assert: 1 nextOddOrSelf equals: 1;
		assert: 2 nextOddOrSelf equals: 3
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testPreviousEven [

	self
		assert: -2 previousEven equals: -4;
		assert: -1 previousEven equals: -2;
		assert: 0 previousEven equals: -2;
		assert: 1 previousEven equals: 0;
		assert: 2 previousEven equals: 0
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testPreviousEvenOrSelf [

	self
		assert: -2 previousEvenOrSelf equals: -2;
		assert: -1 previousEvenOrSelf equals: -2;
		assert: 0 previousEvenOrSelf equals: 0;
		assert: 1 previousEvenOrSelf equals: 0;
		assert: 2 previousEvenOrSelf equals: 2
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testPreviousOdd [

	self
		assert: -2 previousOdd equals: -3;
		assert: -1 previousOdd equals: -3;
		assert: 0 previousOdd equals: -1;
		assert: 1 previousOdd equals: -1;
		assert: 2 previousOdd equals: 1
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testPreviousOddOrSelf [

	self
		assert: -2 previousOddOrSelf equals: -3;
		assert: -1 previousOddOrSelf equals: -1;
		assert: 0 previousOddOrSelf equals: -1;
		assert: 1 previousOddOrSelf equals: 1;
		assert: 2 previousOddOrSelf equals: 1
]

{ #category : '*Containers-Essentials-Tests' }
IntegerTest >> testShiftOfNegativeOne [

	| a |
	a := -1.

	self
		assert: a >> 1 equals: -1;
		assert: a // 2 equals: -1
]
