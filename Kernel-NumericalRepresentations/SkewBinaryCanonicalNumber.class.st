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
		representation:
			(ValueLink new
				value: i;
				nextLink: aValueLink;
				yourself);
		yourself
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> decrement [
	^ self
		decrementIfOne: #yourself
		otherwise: [ :aSkewNumber :aValue | aSkewNumber ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> decrementIfOne: oBlock otherwise: eBlock [
	^ representation
		ifNil: [ self error ]
		ifNotNil: [ | w |
			w := self key: representation.
			w = 1
				ifTrue: [ oBlock value: self cdr ]
				ifFalse: [ | v twin |
					v := w // 2.
					twin := self
						cons: v
						onto:
							(ValueLink new
								value: v;
								nextLink: representation nextLink;
								yourself).
					eBlock value: twin value: representation value ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> increment [
	^ self
		incrementIfEmpty: #yourself
		ifSingleton: #yourself
		twoInARow: [ :aSkewNumber :b :c | aSkewNumber ]
		otherwise: #yourself
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> incrementIfEmpty: eBlock ifSingleton: sBlock twoInARow: tBlock otherwise: oBlock [
	^ representation
		ifNil: [ eBlock value: (self cons: 1) ]
		ifNotNil: [ representation nextLink
				ifNil: [ sBlock value: (self cons: 1) ]
				ifNotNil: [ :nr | 
					| v w |
					v := self key: representation.
					w := self key: nr.
					v = w
						ifTrue: [ tBlock
								value: (self cons: 1 + v + w onto: nr nextLink)
								value: representation value
								value: nr value ]
						ifFalse: [ oBlock value: (self cons: 1) ] ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> key: aValueLink [
	^ aValueLink value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]
