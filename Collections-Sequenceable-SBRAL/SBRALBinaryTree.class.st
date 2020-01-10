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
SBRALBinaryTree >> content [
	^ content
]

{ #category : #accessing }
SBRALBinaryTree >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
SBRALBinaryTree >> ifLeaf: lBlock ifNode: nBlock [
	self subclassResponsibility
]
