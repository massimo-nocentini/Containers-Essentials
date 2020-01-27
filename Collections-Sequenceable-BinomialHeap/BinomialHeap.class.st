Class {
	#name : #BinomialHeap,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Collections-Sequenceable-BinomialHeap'
}

{ #category : #creating }
BinomialHeap class >> trees: trees [
	^ self new
		representation: trees;
		yourself
]

{ #category : #adding }
BinomialHeap >> cons: anAssociation onto: trees [
	^ self class new
		representation: anAssociation ~~> trees;
		yourself
]

{ #category : #adding }
BinomialHeap >> ifEmpty: eBlock ifNotEmpty: neBlock [
	^ representation ifNil: eBlock ifNotNil: neBlock
]

{ #category : #adding }
BinomialHeap >> merge: trees with: otherTrees [
	^ trees
		ifNil: [ otherTrees ]
		ifNotNil: [ otherTrees
				ifNil: [ trees ]
				ifNotNil:
					[ | aTree anotherTree allButFirstTrees allButFirstOtherTrees aRank anotherRank |
					"Getting rests of both collections of trees to merge."
					allButFirstTrees := trees nextLink.
					allButFirstOtherTrees := otherTrees nextLink.

					"Getting current topmost trees."
					aTree := trees value.
					anotherTree := otherTrees value.

					"Getting ranks."
					aRank := aTree key.
					anotherRank := anotherTree key.

					"Rank comparison via `#key`."
					aRank < anotherRank
						ifTrue: [ aTree ~~> (self merge: allButFirstTrees with: otherTrees) ]
						ifFalse: [ anotherRank < aRank
								ifTrue: [ anotherTree ~~> (self merge: trees with: allButFirstOtherTrees) ]
								ifFalse: [ | binomialTree mergedTrees |
									binomialTree := aTree value
										linkBinomialTree: anotherTree value.
									mergedTrees := self
										merge: allButFirstTrees
										with: allButFirstOtherTrees.
									self pushTree: aRank + 1 -> binomialTree onTrees: mergedTrees ] ] ] ]
]

{ #category : #adding }
BinomialHeap >> min [
	^ self
		ifEmpty: [ CollectionIsEmpty signal ]
		ifNotEmpty: [ :trees | (self min: trees) first value content ]
]

{ #category : #adding }
BinomialHeap >> min: trees [
	| tree |
	tree := trees value.
	^ trees nextLink
		ifNil: [ Array with: tree with: nil ]
		ifNotNil: [ :nl | 
			| tuple anotherTree |
			tuple := self min: nl.
			anotherTree := tuple first.
			tree value content <= anotherTree value content
				ifTrue: [ Array with: tree with: nl ]
				ifFalse: [ Array with: anotherTree with: tree ~~> tuple second ] ]
]

{ #category : #adding }
BinomialHeap >> pop [
	^ self
		ifEmpty: [ CollectionIsEmpty signal ]
		ifNotEmpty: [ :trees | 
			| tuple tree mergedTrees |
			tuple := self min: trees.
			tree := tuple first.
			mergedTrees := self
				merge:
					((tree key - 1 to: 0 by: -1) asLink
						with: tree value children
						collect: #->)
				with: tuple second.
			self class trees: mergedTrees ]
]

{ #category : #adding }
BinomialHeap >> push: x [
	| trees |
	trees := self
		pushTree: 0 -> (BinomialTree leaf: x)
		onTrees: representation.
	^ self class trees: trees
]

{ #category : #adding }
BinomialHeap >> pushTree: anAssociation onTrees: trees [
	^ trees
		ifNil: [ anAssociation ~~> trees ]
		ifNotNil: [ | carAssociation rank |
			rank := anAssociation key.
			carAssociation := trees value.
			rank < carAssociation key
				ifTrue: [ anAssociation ~~> trees ]
				ifFalse: [ self
						pushTree:
							rank + 1
								-> (anAssociation value linkBinomialTree: carAssociation value)
						onTrees: trees nextLink ] ]
]

{ #category : #accessing }
BinomialHeap >> representation: anObject [
	representation := anObject
]
