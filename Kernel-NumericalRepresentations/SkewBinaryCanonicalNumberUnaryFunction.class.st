Class {
	#name : #SkewBinaryCanonicalNumberUnaryFunction,
	#superclass : #Object,
	#instVars : [
		'skewNumber'
	],
	#category : #'Kernel-NumericalRepresentations'
}

{ #category : #'instance creation' }
SkewBinaryCanonicalNumberUnaryFunction class >> on: aSkewNumber [
	^ self new
		skewNumber: aSkewNumber;
		yourself
]

{ #category : #accessing }
SkewBinaryCanonicalNumberUnaryFunction >> skewNumber: anObject [
	skewNumber := anObject
]

{ #category : #evaluating }
SkewBinaryCanonicalNumberUnaryFunction >> value [
	self subclassResponsibility
]
