Class {
	#name : #RandomExponential,
	#superclass : #Random,
	#instVars : [
		'lambda'
	],
	#category : #'Containers-Essentials'
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

	^ (1 - super next) ln negated / lambda
]
