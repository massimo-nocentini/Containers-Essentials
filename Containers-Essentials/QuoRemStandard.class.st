Class {
	#name : #QuoRemStandard,
	#superclass : #QuoRemComplementary,
	#category : #'Containers-Essentials'
}

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
	absRem := rem ifNegative: [ 0 ] ifZero: [ 0 ] ifPositive: #yourself.

	^ super numberOfDots + absRem
]
