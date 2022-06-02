"
I am a variant that enriches the slot descriptors for Integer objects.
"
Class {
	#name : #CTSlotDescriptorsVisitorDetails,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorDetails >> visitFraction: aFraction [

	^ { ((self newSlotDescriptorSelector: #asShapeNaturalRepresentation)
		   inline;
		   quote) } , (self visitObject: aFraction) , { 
		  (self newSlotDescriptorSelector: #floor).
		  (self newSlotDescriptorSelector: #asFloat).

		  ((self newSlotDescriptorSelector: #asPythagoreanTriple)
			   inline;
			   noHeader;
			   quote: [ :aTriple :aDfsWalker | 
				   aTriple asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #asShapeOnUnitCircle)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitorDetails >> visitInteger: anInteger [

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
