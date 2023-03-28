Class {
	#name : #SymbolicIntegerTest,
	#superclass : #IntegerTest,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests-Tests'
}

{ #category : #tests }
SymbolicIntegerTest >> testComplementaryQuoRem21Over9 [

	| quoRem |
	quoRem := 21 /%~ 9.

	self assert: quoRem equals: 21 / 9.

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testComplementaryQuoRem9Over21 [

	| quoRem |
	quoRem := 9 /%~ 21.

	self assert: quoRem equals: 9 / 21.

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDof12and21 [

	| quoRem |
	quoRem := 12 >|< 21.

	self assert: quoRem equals: (12 gcd: 21).

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDof83and71 [

	| quoRem |
	quoRem := 83 >|< 71.

	self assert: quoRem equals: (83 gcd: 71).

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDof9and21 [

	| quoRem |
	quoRem := 9 >|< 21.

	self assert: quoRem equals: (9 gcd: 21).

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDofAdjacentFibonacciNumbers [

	| fibs gcds |
	fibs := OrderedCollection with: 1 with: 1.

	3 to: 11 do: [ :i | fibs add: (fibs at: i - 2) + (fibs at: i - 1) ].

	gcds := fibs
		        with: fibs allButFirst , { (fibs lastButOne + fibs last) }
		        collect: [ :r :s | r >|< s ].

	self assert: gcds equals: (gcds collect: [ :each | 1 ]).

	^ self exportSlotsGraphOf: gcds
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDofMultiplicativeInversesInZ17 [

	| gcds inverses |
	gcds := self testGCDofZ17.
	inverses := PointArray new: gcds size.
	gcds withIndexDo: [ :each :index | 
		inverses at: index put: each b @ each inverseMultiplicativeOfb key ].

	^ self exportSlotsGraphOf: inverses
]

{ #category : #tests }
SymbolicIntegerTest >> testGCDofZ17 [

	| field prime interval |
	prime := 17.
	interval := 1 to: prime - 1.
	field := interval collect: [ :each | each >|< prime ].

	self
		assert: field
		equals: (interval collect: [ :each | prime gcd: each ]).

	^ self exportSlotsGraphOf: field
]

{ #category : #tests }
SymbolicIntegerTest >> testQuoRem9Over21 [

	| quoRem |
	quoRem := 9 /% 21.

	self assert: quoRem equals: 9 / 21.

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testQuoRemMinimal9Over21 [

	| quoRem |
	quoRem := 9 /%< 21.

	self assert: quoRem equals: 9 / 21.

	^ self exportSlotsGraphOf: quoRem
]

{ #category : #tests }
SymbolicIntegerTest >> testStandardQuoRem21Over9 [

	| quoRem |
	quoRem := 21 /% 9.

	self assert: quoRem equals: 21 / 9.

	^ self exportSlotsGraphOf: quoRem
]
