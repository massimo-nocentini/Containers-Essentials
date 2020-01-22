Class {
	#name : #SkewBinaryCanonicalNumber,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Kernel-NumericalRepresentations'
}

{ #category : #accessing }
SkewBinaryCanonicalNumber class >> denseRepresentationOfInteger: i weight: w [
	^ i < w
		ifTrue: [ Array with: i with: nil ]
		ifFalse: [ | rest linker tuple |
			tuple := self denseRepresentationOfInteger: i weight: 2 * w + 1.
			rest := tuple first.
			linker := [ :digit | 
			ValueLink new
				value: digit;
				nextLink: tuple second;
				yourself ].
			2 * w = rest
				ifTrue: [ Array with: 0 with: (linker value: 2) ]
				ifFalse: [ w <= rest
						ifTrue: [ Array with: rest - w with: (linker value: 1) ]
						ifFalse: [ Array with: rest with: (linker value: 0) ] ] ]
]

{ #category : #'instance creation' }
SkewBinaryCanonicalNumber class >> fromInteger: i [
	^ self new
		representation:
			(i isZero
				ifTrue: [ ValueLink value: 0 ]
				ifFalse: [ (self denseRepresentationOfInteger: i weight: 1) second ]);
		yourself
]

{ #category : #converting }
SkewBinaryCanonicalNumber >> asInteger [
	| value vl |
	value := 0.
	vl := representation.
	[ vl isNil ]
		whileFalse: [ value := value + vl value.
			vl := vl nextLink ].
	^ value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> cdr [
	^ self class new
		representation: representation nextLink;
		yourself
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> cons: i [
	^ self cons: i onto: representation
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> cons: i onto: aValueLink [
	^ self class new
		representation: i ~~> aValueLink;
		yourself
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> decrement [
	^ representation
		ifNil: [ ArithmeticError signal ]
		ifNotNil: [ | w |
			w := self key: representation.
			w = 1
				ifTrue: [ self decrementedBitOne: self cdr ]
				ifFalse: [ | v twin |
					v := w // 2.
					twin := self cons: v onto: v ~~> representation nextLink.
					self decremented: twin bitZeroOrTwo: representation value ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> decremented: aSkewNumber bitZeroOrTwo: aValue [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> decrementedBitOne: aSkewNumber [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> increment [
	^ representation
		ifNil: [ self incrementedZero: (self cons: 1) ]
		ifNotNil: [ representation nextLink
				ifNil: [ self incrementedSingleton: (self cons: 1) ]
				ifNotNil: [ :nr | 
					| v w |
					v := self key: representation.
					w := self key: nr.
					v = w
						ifTrue: [ self
								incremented: (self cons: 1 + v + w onto: nr nextLink)
								two: representation value
								inARow: nr value ]
						ifFalse: [ self incrementedDifferentBits: (self cons: 1) ] ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> incremented: aSkewNumber two: aValue inARow: anotherValue [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> incrementedDifferentBits: aSkewNumber [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> incrementedSingleton: aSkewNumber [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> incrementedZero: aSkewNumber [
	^ aSkewNumber
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> key: aValueLink [
	^ aValueLink value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]
