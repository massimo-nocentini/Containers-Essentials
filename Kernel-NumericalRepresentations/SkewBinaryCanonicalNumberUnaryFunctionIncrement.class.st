Class {
	#name : #SkewBinaryCanonicalNumberUnaryFunctionIncrement,
	#superclass : #SkewBinaryCanonicalNumberUnaryFunction,
	#category : #'Kernel-NumericalRepresentations'
}

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionIncrement >> incrementBy: weight onto: aRepresentation two: currentValue inARow: nextValue [
	^ skewNumber cons: weight onto: aRepresentation
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionIncrement >> incrementDifferentAdjacentBits [
	^ skewNumber cons: 1
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionIncrement >> incrementLastDigit [
	^ skewNumber cons: 1
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionIncrement >> incrementZero [
	^ skewNumber cons: 1
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionIncrement >> value [
	^ skewNumber
		ifZero: [ self incrementZero ]
		ifNotZero: [ :representation | 
			representation nextLink
				ifNil: [ self incrementLastDigit ]
				ifNotNil: [ :nr | 
					| v w |
					v := skewNumber key: representation.
					w := skewNumber key: nr.
					v = w
						ifTrue: [ self
								incrementBy: 1 + v + w
								onto: nr nextLink
								two: representation value
								inARow: nr value ]
						ifFalse: [ self incrementDifferentAdjacentBits ] ] ]
]
