"
I am a variant that enriches the slot descriptors for Integer objects.
"
Class {
	#name : #CTSlotDescriptorsVisitorIntegerDetails,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorIntegerDetails >> visitInteger: anInteger [

	^ { 
		  (self newSlotDescriptorSelector: #asStringDecimal) inline.
		  (self newSlotDescriptorSelector: #asStringHex) inline.
		  (self newSlotDescriptorSelector: #asStringOctal) inline.
		  (self newSlotDescriptorSelector: #asStringBinary) inline.
		  (self newSlotDescriptorSelector: #asStringBRGC) inline.
		  (self newSlotDescriptorSelector: #asStringSkew) inline.
		  (self newSlotDescriptorSelector: #numberOfDigits).
		  (self newSlotDescriptorSelector: #numberOfDigitsInBase2).
		  ((self
			    newSlotDescriptorString: #asShapeBinaryDots:
			    constant: anInteger)
			   inline;
			   quoteUsingSelector).
		  ((self
			    newSlotDescriptorString: #asShapeBRGCDots:
			    constant: anInteger)
			   inline;
			   quoteUsingSelector).
		  ((self
			    newSlotDescriptorString: #asShapeSkewDots:
			    constant: anInteger)
			   inline;
			   quoteUsingSelector).
		  (self newSlotDescriptorSelector: #asStringAZaz) inline.
		  (self newSlotDescriptorSelector: #asStringaz) inline.
		  (self newSlotDescriptorSelector: #isProbablyPrime).
		  ((self newSlotDescriptorSelector: #isPrime) enablePredicate: [ 
			   anInteger isProbablyPrime ]) }
]
