Class {
	#name : #AlgorithmX,
	#superclass : #Object,
	#category : #'Collections-DoubleLinkedList-DancingLinks-exact cover'
}

{ #category : #searching }
AlgorithmX >> searchDepth: k partialSolution: sol collector: aBlock forDLColumnObject: c [
	c cover.
	c
		untilFixPointOf: [:co | co down]
		do: [ :r | 
			self
				searchDepth: k
				partialSolution: sol
				collector: aBlock
				forDLDataObject: r ].
	c uncover
]

{ #category : #searching }
AlgorithmX >> searchDepth: k partialSolution: sol collector: aBlock forDLDataObject: r [
	sol
		with: k -> r
		enter: [ r
				untilFixPointOf: [ :ro | ro right ]
				do: [ :j | j column cover ] ]
		do: [ self
				searchDepth: k + 1
				partialSolution: sol
				collector: aBlock
				forDLRootObject: r column root ]
		exit: [ r untilFixPointOf: [ :ro | ro left ] do: [ :j | j column uncover ] ]
]

{ #category : #searching }
AlgorithmX >> searchDepth: k partialSolution: sol collector: aBlock forDLRootObject: h [
	^ (h isFixPointOf: [:ho | ho right])
		ifTrue: [ aBlock value: sol copy ]
		ifFalse: [ self
				searchDepth: k
				partialSolution: sol
				collector: aBlock
				forDLColumnObject: h chooseColumn ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h [
	^ self solutionsFor: h withPost: [ :aDLDataObject | aDLDataObject model ]
]

{ #category : #searching }
AlgorithmX >> solutionsFor: h withPost: aBlock [
	^ Generator
		on: [ :generator | 
			self
				searchDepth: 0
				partialSolution: Dictionary new
				collector: [ :aDict | 
					| subjects |
					subjects := aDict values collect: aBlock.
					generator yield: (Set withAll: subjects) ]
				forDLRootObject: h ]
]
