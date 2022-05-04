Class {
	#name : #CTConditionDfsWalkerShouldSkip,
	#superclass : #CTConditionIfFalse,
	#instVars : [
		'child',
		'descriptor',
		'condition'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerShouldSkip >> caller: anObject [

	condition := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldSkip >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldSkip >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldSkip >> falsehood [

	^ condition shouldntSkip: child descriptor: descriptor
]
