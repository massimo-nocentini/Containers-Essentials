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
		  (self newSlotDescriptor
			   selector: #asStringDecimal;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringHex;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringOctal;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringBinary;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringBRGC;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringSkew;
			   inline).
		  (self newSlotDescriptor selector: #numberOfDigits).
		  (self newSlotDescriptor selector: #numberOfDigitsInBase2).
		  (self newSlotDescriptor
			   selector: #asShapeBinaryDots:;
			   inline;
			   quote).
		  (self newSlotDescriptor
			   selector: #asShapeBRGCDots:;
			   inline;
			   quote).
		  (self newSlotDescriptor
			   selector: #asShapeSkewDots:;
			   inline;
			   quote).
		  (self newSlotDescriptor
			   selector: #asStringAZaz;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringaz;
			   inline).
		  (self newSlotDescriptor selector: #isProbablyPrime).
		  (self newSlotDescriptor
			   selector: #isPrime;
			   enablePredicate: [ anInteger isProbablyPrime ]) }
]
