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
	^ representation
		ifNil: [ self error ]
		ifNotNil: [ | w |
			w := representation value.
			w = 1
				ifTrue: [ self cdr ]
				ifFalse: [ | v |
					v := w // 2.
					self
						cons: v
						onto:
							(ValueLink new
								value: v;
								nextLink: representation nextLink;
								yourself) ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> increment [
	^ representation
		ifNil: [ self cons: 1 ]
		ifNotNil: [ representation nextLink
				ifNil: [ self cons: 1 ]
				ifNotNil: [ :nr | 
					| v w |
					v := representation value.
					w := nr value.
					v = w
						ifTrue: [ self cons: 1 + v + w onto: nr nextLink ]
						ifFalse: [ self cons: 1 ] ] ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]
