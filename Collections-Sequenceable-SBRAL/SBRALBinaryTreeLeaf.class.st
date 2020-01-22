Class {
	#name : #SBRALBinaryTreeLeaf,
	#superclass : #SBRALBinaryTree,
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #accessing }
SBRALBinaryTreeLeaf >> at: i key: aKey SBRAL: aSBRAL ifPresent: pBlock ifAbsent: aBlock [
	^ aBlock value
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeLeaf >> at: i put: y key: aKey SBRAL: aSBRAL ifAbsent: aBlock [
	^ aBlock value
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeLeaf >> decrementSBRAL: aSbral [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
SBRALBinaryTreeLeaf >> put: y [
	^ self class leaf: y
]
