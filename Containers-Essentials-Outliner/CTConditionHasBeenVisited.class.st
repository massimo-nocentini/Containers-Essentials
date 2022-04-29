Class {
	#name : #CTConditionHasBeenVisited,
	#superclass : #CTCondition,
	#instVars : [
		'child',
		'descriptor',
		'parent',
		'shape',
		'level',
		'walker'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionHasBeenVisited >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionHasBeenVisited >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionHasBeenVisited >> falsehood [

	^ walker
		  hasntBeenVisited: child
		  descriptor: descriptor
		  parent: parent
		  shape: shape
		  level: level
]

{ #category : #accessing }
CTConditionHasBeenVisited >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionHasBeenVisited >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTConditionHasBeenVisited >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionHasBeenVisited >> truthWitness: anAlreadySeenShape [

	^ walker hasBeenVisited: anAlreadySeenShape childOfShape: shape
]

{ #category : #accessing }
CTConditionHasBeenVisited >> walker: anObject [

	walker := anObject
]
