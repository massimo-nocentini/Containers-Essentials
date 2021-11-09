Extension { #name : #IntegerTest }

{ #category : #'*Containers-Essentials-Tests' }
IntegerTest >> testAsStringAZaz [

	| n |
	self
		assert: 0 asStringAZaz equals: 'k';
		assert: 1 asStringAZaz equals: 'l';
		assert: 10 asStringAZaz equals: 'A';
		assert: 15 asStringAZaz equals: 'F';
		assert: 16 asStringAZaz equals: 'G';
		assert: 26 asStringAZaz equals: 'Q';
		assert: 51 asStringAZaz equals: 'j';
		assert: 52 asStringAZaz equals: 'lk'.

	"Ensure #asStringAZaz is a bijection: for the sake of clarity,
	 to each integer corresponds an unique AZaz representation."
	n := 10000.
	self
		assert:
		((1 to: n) collect: [ :each | each asStringAZaz ] as: Set) size
		equals: n
]
