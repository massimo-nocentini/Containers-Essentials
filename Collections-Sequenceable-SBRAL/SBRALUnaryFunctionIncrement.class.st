Class {
	#name : #SBRALUnaryFunctionIncrement,
	#superclass : #SkewBinaryCanonicalNumberUnaryFunctionIncrement,
	#instVars : [
		'element'
	],
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #accessing }
SBRALUnaryFunctionIncrement >> element: anObject [
	element := anObject
]

{ #category : #evaluating }
SBRALUnaryFunctionIncrement >> incrementBy: weight onto: aRepresentation two: currentValue inARow: nextValue [
	| sbral |
	sbral := super
		incrementBy: weight
		onto: aRepresentation
		two: currentValue
		inARow: nextValue.
	^ sbral
		tree:
			(SBRALBinaryTree
				node: element
				left: currentValue value
				right: nextValue value)
]

{ #category : #evaluating }
SBRALUnaryFunctionIncrement >> incrementDifferentAdjacentBits [
	^ super incrementDifferentAdjacentBits
		tree: (SBRALBinaryTree leaf: element)
]

{ #category : #evaluating }
SBRALUnaryFunctionIncrement >> incrementLastDigit [
	^ super incrementLastDigit tree: (SBRALBinaryTree leaf: element)
]

{ #category : #evaluating }
SBRALUnaryFunctionIncrement >> incrementZero [
	^ super incrementZero tree: (SBRALBinaryTree leaf: element)
]
