Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Collections-Unordered-Graph'
}

{ #category : #tests }
GraphTest >> testGraph [
	| G |
	G := {(#a -> #b weight: 1).
	(#b -> #c weight: 2).
	(#c -> #d weight: 1).
	(#d -> #a weight: 4).
	(#c -> #a weight: 9)} asGraph.
	self assert: {#b} equals: G vertices @ #a @ #outgoings.
	self assert: {#d . #c} equals: G vertices @ #a @ #incomings
]
