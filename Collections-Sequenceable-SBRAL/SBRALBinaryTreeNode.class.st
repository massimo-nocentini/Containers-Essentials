Class {
	#name : #SBRALBinaryTreeNode,
	#superclass : #SBRALBinaryTree,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #accessing }
SBRALBinaryTreeNode >> at: i key: aKey SBRAL: aSBRAL ifPresent: pBlock ifAbsent: aBlock [
	^ aSBRAL
		at: i
		key: aKey
		node: self
		ifPresent: pBlock
		ifAbsent: aBlock
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeNode >> at: i put: y key: aKey SBRAL: aSBRAL ifAbsent: aBlock [
	^ aSBRAL
		at: i
		put: y
		key: aKey
		node: self
		ifAbsent: aBlock
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeNode >> decrementSBRAL: aSbral [
	aSbral tree: left.
	aSbral cdr tree: right.
	^ aSbral
]

{ #category : #accessing }
SBRALBinaryTreeNode >> left [
	^ left
]

{ #category : #accessing }
SBRALBinaryTreeNode >> left: anObject [
	left := anObject
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeNode >> put: y [
	^ self class node: y left: left right: right
]

{ #category : #accessing }
SBRALBinaryTreeNode >> right [
	^ right
]

{ #category : #accessing }
SBRALBinaryTreeNode >> right: anObject [
	right := anObject
]
