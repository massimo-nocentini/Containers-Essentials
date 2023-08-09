Class {
	#name : #RandomInteger,
	#superclass : #Random,
	#instVars : [
		'atLeast',
		'atMost'
	],
	#category : #'Containers-Essentials-Random'
}

{ #category : #accessing }
RandomInteger >> atLeast: anObject [

	atLeast := anObject
]

{ #category : #accessing }
RandomInteger >> atMost: anObject [

	atMost := anObject
]

{ #category : #initialization }
RandomInteger >> initialize [

	super initialize.

	self
		atLeast: 0;
		atMost: SmallInteger maxVal
]

{ #category : #accessing }
RandomInteger >> next [

	^ self nextIntegerBetween: atLeast and: atMost
]
