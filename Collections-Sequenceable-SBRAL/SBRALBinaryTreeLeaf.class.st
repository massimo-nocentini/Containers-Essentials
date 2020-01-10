Class {
	#name : #SBRALBinaryTreeLeaf,
	#superclass : #SBRALBinaryTree,
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #'as yet unclassified' }
SBRALBinaryTreeLeaf >> ifLeaf: lBlock ifNode: nBlock [
	^ lBlock value: self
]
