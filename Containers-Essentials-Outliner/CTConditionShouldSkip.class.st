Class {
	#name : #CTConditionShouldSkip,
	#superclass : #CTConditionIfFalse,
	#instVars : [
		'caller',
		'child',
		'descriptor'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionShouldSkip >> caller: anObject [

	caller := anObject
]

{ #category : #accessing }
CTConditionShouldSkip >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionShouldSkip >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionShouldSkip >> falsehood [

	^ caller shouldntSkip: child descriptor: descriptor
]
