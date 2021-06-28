Class {
	#name : #RandomExponential,
	#superclass : #Random,
	#instVars : [
		'lambda'
	],
	#category : #'Containers-Essentials-Random'
}

{ #category : #'*Containers-Essentials' }
RandomExponential >> densityOfNumber: x [

	^ lambda * (lambda * x) negated exp
]

{ #category : #initialization }
RandomExponential >> initialize [

	super initialize.

	self lambda: 1
]

{ #category : #accessing }
RandomExponential >> lambda: anObject [

	lambda := anObject
]

{ #category : #accessing }
RandomExponential >> next [

	^ (1 - super next) ln negated / lambda
]
