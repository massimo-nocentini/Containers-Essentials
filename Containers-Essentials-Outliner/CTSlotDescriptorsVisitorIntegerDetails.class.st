Class {
	#name : #CTSlotDescriptorsVisitorIntegerDetails,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorIntegerDetails >> visitInteger: anInteger [

	^ { 
		  (#asStringDecimal asSlotDescriptor inline: true).
		  (#asStringHex asSlotDescriptor inline: true).
		  (#asStringOctal asSlotDescriptor inline: true).
		  (#asStringBinary asSlotDescriptor inline: true).
		  (#asStringBRGC asSlotDescriptor inline: true).
		  (#asStringSkew asSlotDescriptor inline: true).
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
