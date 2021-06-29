Extension { #name : #CTIntegerRepresentationsView }

{ #category : #'*Containers-Essentials-Visualizations' }
CTIntegerRepresentationsView >> instVarsNamesOrderedCollection [

	^ { 
		  #decimal asSlotDescriptor inline.

		  #hex asSlotDescriptor inline.

		  #octal asSlotDescriptor inline.

		  #binary asSlotDescriptor inline.

		  #brgc asSlotDescriptor inline.

		  #skew asSlotDescriptor inline.

		  #asShapeBinaryDots asSlotDescriptor quote.

		  #asShapeBRGCDots asSlotDescriptor quote.

		  #asShapeSkewDots asSlotDescriptor quote.

		  "#asWords asSlotDescriptor"

		  " ('skew (sparse)'
		   -> [ :anObject | integer skewBinaryCanonicalSparseRepresentation ])" }
	  , ((integer between: 0 and: 16r10FFFF)
			   ifTrue: [ 
			   { ('character' -> [ :anObject | integer asCharacter ]) } ]
			   ifFalse: [ #(  ) ])
]
