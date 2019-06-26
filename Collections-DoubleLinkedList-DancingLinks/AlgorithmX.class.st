Class {
	#name : #AlgorithmX,
	#superclass : #Object,
	#instVars : [
		'sol'
	],
	#category : #'Collections-DoubleLinkedList-DancingLinks-exact cover'
}

{ #category : #searching }
AlgorithmX >> search: k addInto: aCollection forDLColumnObject: c [
	| chain |
	chain := Chain bottom.
	c cover.
	c
		untilFixPointForDirection: #down
		do: [ :r | 
			chain := chain mplus: [  self search: k addInto: aCollection forDLDataObject: r ] sequential: Sequential new ].
	c uncover.
	^ chain
]

{ #category : #searching }
AlgorithmX >> search: k addInto: aCollection forDLDataObject: r [
	^ sol
		with: k -> r
		enter: [ r untilFixPointForDirection: #right do: [ :j | j column cover ] ]
		do: [ self
				search: k + 1
				addInto: aCollection
				forDLRootObject: r column root ]
		exit: [ r untilFixPointForDirection: #left do: [ :j | j column uncover ] ]
]

{ #category : #searching }
AlgorithmX >> search: k addInto: aCollection forDLRootObject: h [
	^ (h isFixPointForDirection: #right)
		ifTrue: [ Chain with: sol copy ]
		ifFalse: [  self
				search: k
				addInto: aCollection
				forDLColumnObject: h chooseColumn  ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h [
	^ self solutionsFor: h withPost: [ :aDLDataObject | aDLDataObject model ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h withPost: aBlock [
	| sols  chain |
	sol := Dictionary new.
	sols := LinkedList new.
	chain := self search: 0 addInto: sols forDLRootObject: h.
	^ chain
		collect: [ :aDict | 
			| subjects |
			subjects := aDict values collect: aBlock.
			Set withAll: subjects ]
]
