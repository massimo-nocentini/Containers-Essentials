Class {
	#name : #BinomialHeap,
	#superclass : #Object,
	#instVars : [
		'representation'
	],
	#category : #'Collections-Sequenceable-BinomialHeap'
}

{ #category : #adding }
BinomialHeap >> cons: anAssociation onto: trees [
	^ self class new
		representation: anAssociation ~~> trees;
		yourself
]

{ #category : #adding }
BinomialHeap >> min [
	^ representation
		ifNil: [ CollectionIsEmpty signal ]
		ifNotNil: [ (self min: representation) first value content ]
]

{ #category : #adding }
BinomialHeap >> min: trees [
	| tree |
	tree := trees value.
	^ trees nextLink
		ifNil: [ Array with: tree with: {} ]
		ifNotNil: [ :nl | 
			| tuple anotherTree |
			tuple := self min: nl.
			anotherTree := tuple first.
			tree value content <= anotherTree value content
				ifTrue: [ Array with: tree with: nl ]
				ifFalse: [ Array with: anotherTree with: tree ~~> tuple second ] ]
]

{ #category : #adding }
BinomialHeap >> push: x [
	^ self pushTree: 0 -> (BinomialTree leaf: x) onTrees: representation
]

{ #category : #adding }
BinomialHeap >> pushTree: anAssociation onTrees: trees [
	^ trees
		ifNil: [ self cons: anAssociation onto: trees ]
		ifNotNil: [ | carAssociation rank |
			rank := anAssociation key.
			carAssociation := trees value.
			rank < carAssociation key
				ifTrue: [ self cons: anAssociation onto: trees ]
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
