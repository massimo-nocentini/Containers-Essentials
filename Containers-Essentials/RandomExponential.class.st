Class {
	#name : #RandomExponential,
	#superclass : #Random,
	#instVars : [
		'lambda'
	],
	#category : #'Containers-Essentials-Random'
}

{ #category : #initialization }
RandomExponential >> initialize [

	super initialize.

	lambda := 1
]

{ #category : #accessing }
RandomExponential >> lambda: anObject [

	lambda := anObject
]

{ #category : #accessing }
RandomExponential >> next [

	| prob |
	prob := super next min: 1 - Float epsilon.

	^ (1 - prob) reciprocal ln / lambda
]
