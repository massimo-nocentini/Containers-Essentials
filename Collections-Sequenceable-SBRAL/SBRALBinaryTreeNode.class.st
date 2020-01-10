Class {
	#name : #SBRALBinaryTreeNode,
	#superclass : #SBRALBinaryTree,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #'as yet unclassified' }
SBRALBinaryTreeNode >> ifLeaf: lBlock ifNode: nBlock [
	^ nBlock value: self
]

{ #category : #accessing }
SBRALBinaryTreeNode >> left [
	^ left
]

{ #category : #accessing }
SBRALBinaryTreeNode >> left: anObject [
	left := anObject
]

{ #category : #accessing }
SBRALBinaryTreeNode >> right [
	^ right
]

{ #category : #accessing }
SBRALBinaryTreeNode >> right: anObject [
	right := anObject
]
