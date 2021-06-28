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
		  ('decimal' asSlotDescriptor inline blockClosure: [ :anObject | 
			   integer printString ]).

		  ('hex' asSlotDescriptor inline blockClosure: [ :anObject | 
			   integer printStringHex ]).

		  ('octal' asSlotDescriptor inline blockClosure: [ :anObject | 
			   integer printStringBase: 8 ]).

		  ('binary' asSlotDescriptor inline blockClosure: [ :anObject | 
			   integer printStringBase: 2 ]).

		  ('BRGC' asSlotDescriptor inline blockClosure: [ :anObject | 
			   integer bitBRGC printStringBase: 2 ]).

		  ('skew (dense)' asSlotDescriptor inline blockClosure: [ :anObject | 
			   String streamContents: [ :aStream | 
				   integer skewBinaryCanonicalDenseRepresentation reversed do: [ 
					   :each | aStream nextPutAll: each value asString ] ] ]).

		 " ('skew (sparse)'
		   -> [ :anObject | integer skewBinaryCanonicalSparseRepresentation ])" }
	  , ((integer between: 0 and: 16r10FFFF)
			   ifTrue: [ 
			   { ('character' -> [ :anObject | integer asCharacter ]) } ]
			   ifFalse: [ #(  ) ])
]

{ #category : #accessing }
CTIntegerRepresentationsView >> integer: anInteger [

	integer := anInteger
]
