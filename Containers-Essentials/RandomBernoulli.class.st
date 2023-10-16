Class {
	#name : 'RandomBernoulli',
	#superclass : 'Random',
	#instVars : [
		'p'
	],
	#category : 'Containers-Essentials-Random',
	#package : 'Containers-Essentials',
	#tag : 'Random'
}

{ #category : 'accessing' }
RandomBernoulli >> density: x [

	^ p ** x * (1 - p ** (1 - x))
]

{ #category : 'as yet unclassified' }
RandomBernoulli >> ifHead: hBlock ifTail: tBlock [

	^ self next ifZero: tBlock ifNotZero: hBlock
]

{ #category : 'initialization' }
RandomBernoulli >> initialize [

	super initialize.

	self p: 0.5
]

{ #category : 'accessing' }
RandomBernoulli >> next [

	^ (super next < p) asInteger
]

{ #category : 'accessing' }
RandomBernoulli >> p: aNumber [

	p := aNumber
]
