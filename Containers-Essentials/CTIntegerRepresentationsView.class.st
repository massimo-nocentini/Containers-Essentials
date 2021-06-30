Class {
	#name : #CTIntegerRepresentationsView,
	#superclass : #Object,
	#instVars : [
		'integer'
	],
	#category : #'Containers-Essentials-Views'
}

{ #category : #converting }
CTIntegerRepresentationsView >> asShapeBRGCDots [

	^ integer asShapeBRGCDots
]

{ #category : #converting }
CTIntegerRepresentationsView >> asShapeBinaryDots [

	^ integer asShapeBinaryDots
]

{ #category : #converting }
CTIntegerRepresentationsView >> asShapeSkewDots [

	^ integer asShapeSkewDots
]

{ #category : #converting }
CTIntegerRepresentationsView >> asWords [

	^ integer asWords
]

{ #category : #converting }
CTIntegerRepresentationsView >> binary [

	^ integer printStringBase: 2
]

{ #category : #converting }
CTIntegerRepresentationsView >> brgc [

	^ integer bitBRGC printStringBase: 2
]

{ #category : #converting }
CTIntegerRepresentationsView >> decimal [

	^ integer printString
]

{ #category : #converting }
CTIntegerRepresentationsView >> hex [

	^ integer printStringHex
]

{ #category : #accessing }
CTIntegerRepresentationsView >> integer: anInteger [

	integer := anInteger
]

{ #category : #converting }
CTIntegerRepresentationsView >> octal [

	^ integer printStringBase: 8
]

{ #category : #converting }
CTIntegerRepresentationsView >> skew [

	^ String streamContents: [ :aStream | 
		  integer skewBinaryCanonicalDenseRepresentation reversed do: [ 
			  :each | aStream nextPutAll: each asString ] ]
]
