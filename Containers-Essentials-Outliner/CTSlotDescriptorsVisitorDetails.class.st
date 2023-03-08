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
		  (self newSlotDescriptorSelector: #asStringDecimal).
		  (self newSlotDescriptorSelector: #asStringHex).
		  (self newSlotDescriptorSelector: #asStringOctal).
		  (self newSlotDescriptorSelector: #asStringBinary).
		  (self newSlotDescriptorSelector: #asStringBRGC).
		  (self newSlotDescriptorSelector: #asStringSkew).
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
		  (self newSlotDescriptorSelector: #asStringAZaz).
		  (self newSlotDescriptorSelector: #asStringaz).
		  (self newSlotDescriptorSelector: #isProbablyPrime).
		  ((self newSlotDescriptorSelector: #isPrime) enablePredicate: [
			   :level | anInteger isProbablyPrime ]) }
]
