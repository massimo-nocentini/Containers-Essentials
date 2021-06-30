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
		  (#asShapeBinaryDots asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeBRGCDots asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeSkewDots asSlotDescriptor
			   inline: true;
			   quote) }
]
