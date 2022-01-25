Class {
	#name : #CTRelation,
	#superclass : #Object,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Containers-Essentials-Messaging'
}

{ #category : #testing }
CTRelation class >> is: a greaterThan: b [

	^ (a > b
		   ifTrue: [ CTRelationGreaterThan ]
		   ifFalse: [ self ]) new
		  left: a;
		  right: b;
		  yourself
]

{ #category : #accessing }
CTRelation >> left [

	^ left
]

{ #category : #accessing }
CTRelation >> left: anObject [

	left := anObject
]

{ #category : #accessing }
CTRelation >> right [

	^ right
]

{ #category : #accessing }
CTRelation >> right: anObject [

	right := anObject
]

{ #category : #'as yet unclassified' }
CTRelation >> slowExplicitFibonacci: anInteger tail: anotherInteger greaterThanZero: aReceiver [

	^ aReceiver
		  slowExplicitFibonacci: anInteger
		  tail: anotherInteger
		  greaterThanZeroIsFalse: self
]
