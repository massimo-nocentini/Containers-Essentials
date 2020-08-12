Class {
	#name : #SkewBinaryCanonicalNumber,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Kernel-NumericalRepresentations'
}

{ #category : #'instance creation' }
SkewBinaryCanonicalNumber class >> denseRepresentationOfInteger: i [
	^ i isZero
		  ifTrue: [ 0 ~~> nil ]
		  ifFalse: [ 
		  (self denseRepresentationOfInteger: i weight: 1) second ]
]

{ #category : #accessing }
SkewBinaryCanonicalNumber class >> denseRepresentationOfInteger: i weight: w [
	^ i < w
		  ifTrue: [ Array with: i with: nil ]
		  ifFalse: [ 
			  | rest linker tuple |
			  tuple := self denseRepresentationOfInteger: i weight: 2 * w + 1.
			  rest := tuple first.
			  linker := [ :digit | digit ~~> tuple second ].
			  2 * w = rest
				  ifTrue: [ Array with: 0 with: (linker value: 2) ]
				  ifFalse: [ 
					  w <= rest
						  ifTrue: [ Array with: rest - w with: (linker value: 1) ]
						  ifFalse: [ Array with: rest with: (linker value: 0) ] ] ]
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
	^ (SkewBinaryCanonicalNumberUnaryFunctionDecrement on: self) value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> ifZero: zBlock ifNotZero: nzBlock [
	^ representation ifNil: zBlock ifNotNil: nzBlock
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> increment [
	^ (SkewBinaryCanonicalNumberUnaryFunctionIncrement on: self) value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> key: aValueLink [
	^ aValueLink value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> weight [
	^ self key: representation
]
