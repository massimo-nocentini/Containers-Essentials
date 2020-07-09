Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Collections-Unordered-Graph-Tests'
}

{ #category : #tests }
GraphTest >> testCatalanRecurrentGraph [
	<gtExample>
	^ 10
		asGraphWithRecurrence: [ :aPoint | 
			((aPoint y - 1 max: 0) to: aPoint x - 1)
				collect: [ :y | (aPoint x - 1) @ y ] ]
]

{ #category : #tests }
GraphTest >> testFromAdjacencyMatrix [
	<gtExample>
	|n|
	n := 100.
	^ (Array2D
		rows: n
		columns: n
		tabulate: [ :r :c | r - 1 choose: c - 1 ]) asGraph
]

{ #category : #tests }
GraphTest >> testGraph [
	| graph |
	graph := { 
		         (#a -> #b weight: 1).
		         (#b -> #c weight: 2).
		         (#c -> #d weight: 1).
		         (#d -> #a weight: 4).
		         (#c -> #a weight: 9) } asGraph.
	self
		assert: ((graph vertices at: #b) children
				 collect: [ :anEdge | anEdge to content ]
				 as: Set)
		equals: (Set with: #c).
	self
		assert: ((graph vertices at: #a) parents
				 collect: [ :anEdge | anEdge from content ]
				 as: Set)
		equals: (Set with: #d with: #c)
]

{ #category : #tests }
GraphTest >> testPascalRecurrentGraph [
	<gtExample>
	^ 10
		asGraphWithRecurrence: [ :aPoint | 
			((aPoint y - 1 max: 0) to: (aPoint y min: aPoint x - 1))
				collect: [ :y | (aPoint x - 1) @ y ] ]
]

{ #category : #tests }
GraphTest >> testPascalRecurrentGraphExplicit [
	<gtExample>
	^ 10
		asGraphWithRecurrence: [ :aPoint | 
			aPoint y isZero
				ifTrue: [ aPoint x isZero
						ifTrue: [ Array empty ]
						ifFalse: [ Array with: (aPoint x - 1) @ 0 ] ]
				ifFalse: [ aPoint x = aPoint y
						ifTrue: [ Array with: aPoint - 1 ]
						ifFalse: [ Array
								with: (aPoint x - 1) @ (aPoint y - 1)
								with: (aPoint x - 1) @ aPoint y ] ] ]
]
