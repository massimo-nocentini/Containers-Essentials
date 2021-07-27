Class {
	#name : #SlotDescriptorsVisitor,
	#superclass : #Object,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
SlotDescriptorsVisitor >> visit: anObject [

	^ anObject acceptSlotDescriptorsVisitor: self
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitArray: anArray [

	^ anArray withIndexCollect: [ :each :index | 
		  index asString asSlotDescriptor blockClosure: [ each ] ]
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitBehavior: aBehavior [

	^ { 
		  (#name asSlotDescriptor inline: true).
		  #class asSlotDescriptor.
		  #superclass asSlotDescriptor.
		  #typeOfClass asSlotDescriptor.
		  #instanceCount asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitBlockClosure: aBlock [

	| copied |
	copied := aBlock sourceNode allVariables flatCollect: [ :aRBVariable | 
		          | var |
		          var := aBlock outerContext lookupVar: aRBVariable name.
		          var
			          ifNil: [ #(  ) ]
			          ifNotNil: [ 
			          { (var name asSlotDescriptor blockClosure: [ var value ]) } ] ].

	^ (self visitObject: aBlock) , copied
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitCTDoubleValueLink: aValueLink [

	^ { #previousLink asSlotDescriptor }
	  , (self visitValueLink: aValueLink)
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitColor: aColor [

	^ (self visitObject: aColor)
	  , { #asShapeColoredBox asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

	^ (self visitObject: aDateAndTime) , { 
		  (#asTimeZoneString asSlotDescriptor inline: true).
		  #asISO8601String asSlotDescriptor.
		  (#asLocalStringYMDHM asSlotDescriptor inline: true).
		  #dayOfWeekName asSlotDescriptor.
		  #monthName asSlotDescriptor.
		  #month asSlotDescriptor.
		  #dayOfMonth asSlotDescriptor.
		  "		  ('Day of year' -> [ :anObj | anObj dayOfYear ])."
		  #year asSlotDescriptor.
		  (#asTimeString asSlotDescriptor inline: true) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitDoubleLink: aDoubleLink [

	^ { 
		  #previousLink asSlotDescriptor.
		  #value asSlotDescriptor.
		  #nextLink asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitDuration: aDuration [

	^ { 
		  #asDays asSlotDescriptor.
		  #asHours asSlotDescriptor.
		  #asMinutes asSlotDescriptor.
		  #asSeconds asSlotDescriptor.
		  #asMilliSeconds asSlotDescriptor.
		  #asMicroseconds asSlotDescriptor.
		  #asNanoSeconds asSlotDescriptor.
		  (#asStringDHHMMSSµ asSlotDescriptor inline: true) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitFileReference: aFileReference [

	^ (super visitObject: aFileReference) , { 
		  #fullName asSlotDescriptor.
		  #contents asSlotDescriptor.
		  #size asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (super visitObject: aFraction) , { 
		  #floor asSlotDescriptor.
		  "#asFractionWrtFloor asSlotDescriptor."
		  (#asPythagoreanTriple asSlotDescriptor
			   noHeader;
			   inline: true;
			   in: [ :aDescriptor | 
				   aDescriptor quote: [ :anArray | 
						   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ] ]).
		  (#asShapeOnUnitCircle asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  #equations asSlotDescriptor.
		  #point asSlotDescriptor.
		  (#asStringDiophantineEquation asSlotDescriptor inline: true) }
	  , (aGreatestCommonDivisor = 1
			   ifTrue: [ 
				   { 
					   (#inverseMultiplicativeOfa asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree).
					   (#inverseMultiplicativeOfb asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree) } ]
			   ifFalse: [ 
				   { 
					   (#asShapeDividendOverGCD asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree).
					   (#asShapeDivisorOverGCD asSlotDescriptor
						    inline: true;
						    quote: #asShapeSlotsDfsTree) } ])
	".

		  #divisibility asSlotDescriptor"
	"(#asShapeDiophantineEquation asSlotDescriptor
			   inline: true;
			   quote)."
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (super visitObject: aHeap) , { (#asShapeValueTree asSlotDescriptor
		   inline: true;
		   quote) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitInteger: anInteger [

	^ self visitObject: anInteger
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitLink: aLink [

	^ { #nextLink asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitObject: anObject [

	^ anObject class allInstVarNames collect: [ :varName | 
		  varName asSlotDescriptor instVarNameHasBeenGiven ]
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitPoint: aPoint [

	^ (super visitObject: aPoint)
	  , { #asShapeWrtOrigin asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (super visitObject: aPointArray)
	  , { #asShapeDots asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitQuoRemComplementary: aQuoRemComplementary [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #quo asSlotDescriptor.
		  #rem asSlotDescriptor.
		  "(#value asSlotDescriptor
			   blockClosure: [ self value asShapeSlotsDfsTree ];
			   inline: true;
			   quote)."
		  (#asString asSlotDescriptor inline: true).
		  (#asShapeDots asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitRSBoundingShape: aShape [

	^ (super visitObject: aShape)
	  , { #asShapeQuoted asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitStack: aStack [

	^ { #firstLink asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { #value asSlotDescriptor } , (self visitLink: aValueLink)
]
