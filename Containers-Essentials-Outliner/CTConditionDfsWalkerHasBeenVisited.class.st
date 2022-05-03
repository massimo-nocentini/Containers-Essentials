Class {
	#name : #CTConditionDfsWalkerHasBeenVisited,
	#superclass : #CTCondition,
	#instVars : [
		'child',
		'descriptor',
		'parent',
		'shape',
		'level',
		'walker'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> falsehood [

	^ walker
		  hasntBeenVisited: child
		  descriptor: descriptor
		  parent: parent
		  shape: shape
		  level: level
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> truthWitness: anAlreadySeenShape [

	^ walker hasBeenVisited: anAlreadySeenShape childOfShape: shape
]

{ #category : #accessing }
CTConditionDfsWalkerHasBeenVisited >> walker: anObject [

	walker := anObject
]
