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
		  (self newSlotDescriptorSelector
			   selector: #asStringDecimal;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringHex;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringOctal;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringBinary;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringBRGC;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringSkew;
			   inline).
		  (self newSlotDescriptorSelector selector: #numberOfDigits).
		  (self newSlotDescriptorSelector selector: #numberOfDigitsInBase2).
		  ((self
			    newSlotDescriptorLabel: #asShapeBinaryDots:
			    accessor: [ anInteger ])
			   inline;
			   quote: [ :i :aDfsWalker | i asShapeBinaryDots: aDfsWalker ]).
		  ((self
			    newSlotDescriptorLabel: #asShapeBRGCDots:
			    accessor: [ anInteger ])
			   inline;
			   quote: [ :i :aDfsWalker | i asShapeBRGCDots: aDfsWalker ]).
		  ((self
			    newSlotDescriptorLabel: #asShapeSkewDots:
			    accessor: [ anInteger ])
			   inline;
			   quote: [ :i :aDfsWalker | i asShapeSkewDots: aDfsWalker ]).
		  (self newSlotDescriptorSelector
			   selector: #asStringAZaz;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringaz;
			   inline).
		  (self newSlotDescriptorSelector selector: #isProbablyPrime).
		  (self newSlotDescriptorSelector
			   selector: #isPrime;
			   enablePredicate: [ anInteger isProbablyPrime ]) }
]
