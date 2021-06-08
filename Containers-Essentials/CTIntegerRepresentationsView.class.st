Class {
	#name : #CTIntegerRepresentationsView,
	#superclass : #Object,
	#instVars : [
		'integer'
	],
	#category : #'Containers-Essentials-Views'
}

{ #category : #'as yet unclassified' }
CTIntegerRepresentationsView >> instVarsNamesOrderedCollection [

	^ { 
		  ('decimal' -> [ :anObject | integer printString ]).
		  ('hex' -> [ :anObject | integer printStringHex ]).
		  ('octal' -> [ :anObject | integer printStringBase: 8 ]).
		  ('binary' -> [ :anObject | integer printStringBase: 2 ]).
		  ('BRGC' -> [ :anObject | integer bitBRGC printStringBase: 2 ]).
		  ('skew (dense)'
		   -> [ :anObject | 
		   integer skewBinaryCanonicalDenseRepresentation reversed ]).
		  ('skew (sparse)'
		   -> [ :anObject | integer skewBinaryCanonicalSparseRepresentation ]) }
	  , ((integer between: 0 and: 16r10FFFF)
			   ifTrue: [ 
			   { ('character' -> [ :anObject | integer asCharacter ]) } ]
			   ifFalse: [ #(  ) ])
]

{ #category : #accessing }
CTIntegerRepresentationsView >> integer: anInteger [

	integer := anInteger
]
