Class {
	#name : #CTConditionDfsWalkerShouldSkip,
	#superclass : #CTConditionIfFalse,
	#instVars : [
		'caller',
		'child',
		'descriptor'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerShouldSkip >> caller: anObject [

	caller := anObject
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

	^ caller shouldntSkip: child descriptor: descriptor
]
