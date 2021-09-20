Class {
	#name : #RandomBernoulli,
	#superclass : #Random,
	#instVars : [
		'p'
	],
	#category : #'Containers-Essentials-Random'
}

{ #category : #'as yet unclassified' }
RandomBernoulli >> density: x [

	^ p ** x * (1 - p ** (1 - x))
]

{ #category : #accessing }
RandomBernoulli >> next [

	^ (super next < p) asInteger
]

{ #category : #accessing }
RandomBernoulli >> p: aNumber [

	p := aNumber
]
