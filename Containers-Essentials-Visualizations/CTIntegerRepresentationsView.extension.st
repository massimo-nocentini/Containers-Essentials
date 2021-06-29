Extension { #name : #CTIntegerRepresentationsView }

{ #category : #'*Containers-Essentials-Visualizations' }
CTIntegerRepresentationsView >> instVarsNamesOrderedCollection [

	^ { 
		  (#decimal asSlotDescriptor inline: true).

		  (#hex asSlotDescriptor inline: true).

		  (#octal asSlotDescriptor inline: true).

		  (#binary asSlotDescriptor inline: true).

		  (#brgc asSlotDescriptor inline: true).

		  (#skew asSlotDescriptor inline: true).

		  #asShapeBinaryDots asSlotDescriptor quote.

		  #asShapeBRGCDots asSlotDescriptor quote.

		  #asShapeSkewDots asSlotDescriptor quote.

		  (#asShapeSkewDots asSlotDescriptor
			   inline: true;
			   quote) } , ((integer between: 0 and: 16r10FFFF)
		   ifTrue: [ 
		   { ('character' -> [ :anObject | integer asCharacter ]) } ]
		   ifFalse: [ #(  ) ])
]
