Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Collections-Unordered-Graph'
}

{ #category : #tests }
GraphTest >> testGraph [
	| graph |
	graph := {(#a -> #b weight: 1).
	(#b -> #c weight: 2).
	(#c -> #d weight: 1).
	(#d -> #a weight: 4).
	(#c -> #a weight: 9)} asGraph.
	self
		assert:
			((graph vertices at: #b) children
				collect: [ :anEdge | anEdge to content ])
		equals: (Set with: #c).
	self
		assert:
			((graph vertices at: #a) parents
				collect: [ :anEdge | anEdge from content ])
		equals: (Set with: #d with: #c)
]
