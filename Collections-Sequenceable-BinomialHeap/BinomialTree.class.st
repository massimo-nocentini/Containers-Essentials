Class {
	#name : #BinomialTree,
	#superclass : #Object,
	#instVars : [
		'content',
		'children'
	],
	#category : #'Collections-Sequenceable-BinomialHeap'
}

{ #category : #creating }
BinomialTree class >> leaf: anObject [
	^ self node: anObject children: nil
]

{ #category : #creating }
BinomialTree class >> node: anObject children: children [
	^ self new
		content: anObject;
		children: children;
		yourself
]

{ #category : #accessing }
BinomialTree >> children [
	^ children
]

{ #category : #accessing }
BinomialTree >> children: anObject [
	children := anObject
]

{ #category : #accessing }
BinomialTree >> content [
	^ content
]

{ #category : #accessing }
BinomialTree >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
BinomialTree >> linkBinomialTree: aTree [
	| x |
	x := aTree content.
	^ content < x
		ifTrue: [ self class node: content children: aTree ~~> children ]
		ifFalse: [ self class node: x children: self ~~> aTree children ]
]
