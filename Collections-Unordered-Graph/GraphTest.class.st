Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Collections-Unordered-Graph'
}

{ #category : #tests }
GraphTest >> testGraph [
	| G |
	G := {(#a -> #b).
	(#b -> #c).
	(#c -> #d).
	(#d -> #a).
	(#c -> #a)} asGraph.
	self assert: {#b} equals: G vertices @ #a @ #outgoings.
	self assert: {#d . #c} equals: G vertices @ #a @ #incomings
]
