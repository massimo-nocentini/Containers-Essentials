Class {
	#name : #SkewBinaryCanonicalNumber,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Containers-Essentials-Numbers'
}

{ #category : #converting }
SkewBinaryCanonicalNumber >> asInteger [

	| value |
	value := 0.
	representation do: [ :each | value := value + each ].
	^ value
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> cdr [
	^ self class new
		representation: representation nextLink;
		yourself
]

{ #category : #creating }
SkewBinaryCanonicalNumber >> cons: i [
	^ self cons: i onto: representation
]

{ #category : #creating }
SkewBinaryCanonicalNumber >> cons: i onto: aValueLink [
	^ self class new
		representation: i ~~> aValueLink;
		yourself
]

{ #category : #decrement }
SkewBinaryCanonicalNumber >> decrement [

	^ self
		  ifZero: [ ArithmeticError signal ]
		  ifNotZero: [ :aValueLink | 
			  | w |
			  w := self weight.
			  w = 1
				  ifTrue: [ self cdr ]
				  ifFalse: [ 
					  self
						  decrementBitZeroOrTwo: aValueLink value
						  by: w // 2
						  onto: aValueLink nextLink ] ]
]

{ #category : #decrement }
SkewBinaryCanonicalNumber >> decrementBitZeroOrTwo: aValue by: v onto: aRepresentation [

	^ self cons: v onto: v ~~> aRepresentation
]

{ #category : #accessing }
SkewBinaryCanonicalNumber >> ifZero: zBlock ifNotZero: nzBlock [
	^ representation ifNil: zBlock ifNotNil: nzBlock
]

{ #category : #increment }
SkewBinaryCanonicalNumber >> increment [

	^ self ifZero: [ self incrementZero ] ifNotZero: [ :aValueLink | 
		  aValueLink nextLink
			  ifNil: [ self incrementLastDigit ]
			  ifNotNil: [ :nextLink | 
				  | v w |
				  v := self key: aValueLink.
				  w := self key: nextLink.
				  v = w
					  ifTrue: [ 
						  self
							  incrementBy: 1 + v + w
							  onto: nextLink nextLink
							  two: aValueLink value
							  inARow: nextLink value ]
					  ifFalse: [ self incrementDifferentAdjacentBits ] ] ]
]

{ #category : #increment }
SkewBinaryCanonicalNumber >> incrementBy: weight onto: aRepresentation two: currentValue inARow: nextValue [

	^ self cons: weight onto: aRepresentation
]

{ #category : #evaluating }
SkewBinaryCanonicalNumber >> incrementDifferentAdjacentBits [

	^ self cons: 1
]

{ #category : #increment }
SkewBinaryCanonicalNumber >> incrementLastDigit [

	^ self cons: 1
]

{ #category : #increment }
SkewBinaryCanonicalNumber >> incrementZero [

	^ self cons: 1
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
