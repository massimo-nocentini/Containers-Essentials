Class {
	#name : #QuoRemStandard,
	#superclass : #QuoRemComplementary,
	#category : #'Containers-Essentials-Divisibility'
}

{ #category : #converting }
QuoRemStandard >> asPointWithRespectToRem [

	^ super asPointWithRespectToRem negated
]

{ #category : #converting }
QuoRemStandard >> complement [

	^ QuoRemComplementary a: a b: b
]

{ #category : #accessing }
QuoRemStandard >> initialize [

	super initialize.

	quo := self value floor.
	rem := a - (quo * b)
]

{ #category : #converting }
QuoRemStandard >> numberOfDots [

	| absRem |
	absRem := rem ifPositive: #yourself ifNotPositive: [ 0 ].

	^ super numberOfDots + absRem
]
