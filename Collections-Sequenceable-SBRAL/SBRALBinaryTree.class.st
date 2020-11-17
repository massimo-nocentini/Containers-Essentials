Class {
	#name : #SBRALBinaryTree,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #'as yet unclassified' }
SBRALBinaryTree class >> leaf: x [
	^ SBRALBinaryTreeLeaf new
		content: x;
		yourself
]

{ #category : #'as yet unclassified' }
SBRALBinaryTree class >> node: x left: l right: r [
	^ SBRALBinaryTreeNode new
		content: x;
		left: l;
		right: r;
		yourself
]

{ #category : #accessing }
SBRALBinaryTree >> at: i key: aKey SBRAL: aSBRAL ifPresent: pBlock ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SBRALBinaryTree >> at: i put: y key: aKey SBRAL: aSBRAL ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
SBRALBinaryTree >> content [
	^ content
]

{ #category : #accessing }
SBRALBinaryTree >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
SBRALBinaryTree >> decrementSBRAL: aSbral [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SBRALBinaryTree >> put: y [
	^ self subclassResponsibility
]
