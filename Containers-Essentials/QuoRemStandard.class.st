Class {
	#name : #QuoRemStandard,
	#superclass : #QuoRemComplementary,
	#category : #'Containers-Essentials'
}

{ #category : #accessing }
QuoRemStandard >> initialize [

	quo := self asNumber floor.
	rem := a - (quo * b)
]

{ #category : #converting }
QuoRemStandard >> numberOfDots [

	| absRem |
	absRem := rem ifNegative: [ 0 ] ifZero: [ 0 ] ifPositive: #yourself.

	^ super numberOfDots + absRem
]
