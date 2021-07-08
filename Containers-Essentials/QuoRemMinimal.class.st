Class {
	#name : #QuoRemMinimal,
	#superclass : #QuoRemComplementary,
	#category : #'Containers-Essentials'
}

{ #category : #accessing }
QuoRemMinimal >> initialize [

	| ratio floor ceil |
	ratio := self asNumber.

	floor := ratio floor.
	ceil := ratio ceiling.

	quo := ratio - floor < (ceil - ratio)
		       ifTrue: [ floor ]
		       ifFalse: [ ceil ].

	rem := a - (quo * b)
]

{ #category : #converting }
QuoRemMinimal >> numberOfDots [

	| absRem |
	absRem := rem ifNegative: [ 0 ] ifZero: [ 0 ] ifPositive: #yourself.

	^ super numberOfDots + absRem
]
