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
	c cover.
	c
		untilFixPointForDirection: #down
		do: [ :r | 
			self search: k addInto: aCollection forDLDataObject: r
		 ].
	c uncover
]

{ #category : #searching }
AlgorithmX >> search: k addInto: aCollection forDLDataObject: r [
	sol
		with: k -> r
		enter: [ r untilFixPointForDirection: #right do: [ :j | j column cover ] ]
		do: [ self
				search: k + 1
				addInto: aCollection
				forDLRootObject: r column root ]
		exit:
			[ r untilFixPointForDirection: #left do: [ :j | j column uncover ] ]
]

{ #category : #searching }
AlgorithmX >> search: k addInto: aCollection forDLRootObject: h [
	(h isFixPointForDirection: #right)
		ifTrue: [ aCollection add: sol copy ]
		ifFalse: [ self
				search: k
				addInto: aCollection
				forDLColumnObject: h chooseColumn ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h [
	^ self solutionsFor: h withPost: [ :aDLDataObject | aDLDataObject model ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h withPost: aBlock [
	| sols setOfSets |
	sol := Dictionary new.
	sols := LinkedList new.
	self search: 0 addInto: sols forDLRootObject: h.
	setOfSets := Set new.
	sols
		do: [ :aDict | 
			| set |
			set := Set new.
			aDict
				valuesDo: [ :aDLDataObject | set add: (aBlock value: aDLDataObject) ].
			setOfSets add: set ].
	^ setOfSets
]
