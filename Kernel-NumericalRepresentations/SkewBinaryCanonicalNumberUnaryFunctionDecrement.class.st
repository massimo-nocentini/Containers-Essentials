Class {
	#name : #SkewBinaryCanonicalNumberUnaryFunctionDecrement,
	#superclass : #SkewBinaryCanonicalNumberUnaryFunction,
	#category : #'Kernel-NumericalRepresentations'
}

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionDecrement >> decrementBitOne [
	^ skewNumber cdr
]

{ #category : #'as yet unclassified' }
SkewBinaryCanonicalNumberUnaryFunctionDecrement >> decrementBitZeroOrTwo: aValue by: v onto: aRepresentation [
	^ skewNumber cons: v onto: v ~~> aRepresentation
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunctionDecrement >> value [
	^ skewNumber
		ifZero: [ ArithmeticError signal ]
		ifNotZero: [ :representation | 
			| w |
			w := skewNumber weight.
			w = 1
				ifTrue: [ self decrementBitOne ]
				ifFalse: [ self
						decrementBitZeroOrTwo: representation value
						by: w // 2
						onto: representation nextLink ] ]
]
