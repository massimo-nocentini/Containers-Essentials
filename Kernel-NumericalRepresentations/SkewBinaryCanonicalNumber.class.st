Class {
	#name : #SkewBinaryCanonicalNumber,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Kernel-NumericalRepresentations'
}

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
SkewBinaryCanonicalNumber >> representation [
	^ representation
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> representation: aValueLink [
	representation := aValueLink
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> weight [
	^ self key: representation
]
