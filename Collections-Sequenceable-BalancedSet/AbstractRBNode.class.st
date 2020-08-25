Class {
	#name : #AbstractRBNode,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Collections-Sequenceable-BalancedSet'
}

{ #category : #converting }
AbstractRBNode >> asBlackNode [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractRBNode >> balance: aBlock representation: aDoubleLink [
	self subclassResponsibility
]

{ #category : #printing }
AbstractRBNode >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '('.
	value printOn: aStream.
	aStream nextPut: $)
]

{ #category : #evaluating }
AbstractRBNode >> value [
	^ value
]

{ #category : #accessing }
AbstractRBNode >> value: anObject [
	value := anObject
]
