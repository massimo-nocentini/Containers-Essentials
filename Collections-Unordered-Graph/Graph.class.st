Class {
	#name : #Graph,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #'Collections-Unordered-Graph'
}

{ #category : #creating }
Graph class >> fromArray2D: aCollection [
	| associations |
	associations := OrderedCollection new.
	1 to: aCollection rowCount do: [ :r | 
		1 to: r do: [ :c | 
			| v |
			v := aCollection at: r at: c.
			v \\ 2 = 1
				ifTrue: [ associations add: r -> c ] ] ].
	^ associations asGraph
]

{ #category : #creating }
Graph class >> fromSequenceableCollection: aCollection [
	| vertices edges |
	vertices := Dictionary new.
	edges := aCollection
		collect: [ :anAssociation | 
			| from to |
			from := vertices
				at: anAssociation key
				ifAbsentPut: [ anAssociation key asVertex ].
			to := vertices
				at: anAssociation value
				ifAbsentPut: [ anAssociation value asVertex ].
			anAssociation asEdge
				from: from;
				to: to;
				yourself ].
	^ self new
		vertices: vertices;
		edges: edges;
		yourself
]

{ #category : #accessing }
Graph >> associations [
	^ self vertices flatCollect: [ :aParent | 
		  aParent children collect: [ :anEdge | aParent -> anEdge to ] ]
]

{ #category : #accessing }
Graph >> edges [
	^ edges
]

{ #category : #accessing }
Graph >> edges: anObject [
	edges := anObject
]

{ #category : #initialization }
Graph >> initialize [
	
	self class initializeSlots: self.
	vertices := Dictionary new.
	edges := LinkedList new " we don't care about ordering, just the chronological one for insertion time"
]

{ #category : #accessing }
Graph >> vertices [
	^ vertices
]

{ #category : #accessing }
Graph >> vertices: anObject [
	vertices := anObject
]
