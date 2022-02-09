"
I am a variant that enriches the slot descriptors for Integer objects.
"
Class {
	#name : #CTSlotDescriptorsVisitorIntegerDetails,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorIntegerDetails >> visitInteger: anInteger [

	^ { 
		  #asStringDecimal asSlotDescriptor inline.
		  #asStringHex asSlotDescriptor inline.
		  #asStringOctal asSlotDescriptor inline.
		  #asStringBinary asSlotDescriptor inline.
		  #asStringBRGC asSlotDescriptor inline.
		  #asStringSkew asSlotDescriptor inline.
		  #numberOfDigits asSlotDescriptor.
		  #numberOfDigitsInBase2 asSlotDescriptor.
		  (#asShapeBinaryDots: asSlotDescriptor
			   inline;
			   quote).
		  (#asShapeBRGCDots: asSlotDescriptor
			   inline;
			   quote).
		  (#asShapeSkewDots: asSlotDescriptor
			   inline;
			   quote).
		  #asStringAZaz asSlotDescriptor inline.
		  #asStringaz asSlotDescriptor inline }
]
