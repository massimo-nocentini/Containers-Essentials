Class {
	#name : #SlotDescriptorsVisitor,
	#superclass : #Object,
	#instVars : [
		'rootDescriptor'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #copying }
SlotDescriptorsVisitor >> collect: aBlock [

	^ SlotDescriptorsVisitorCollect basicNew
		  slotDescriptorsContext: self;
		  blockClosure: aBlock;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
SlotDescriptorsVisitor >> draw: anObject using: aDrawer walking: aWalker [

	aWalker
		rootObject: anObject;
		slotDescriptorsContext: self.

	^ aDrawer visit: aWalker
]

{ #category : #initialization }
SlotDescriptorsVisitor >> initialize [

	super initialize.

	self rootDescriptor: #yourself asSlotDescriptor
]

{ #category : #accessing }
SlotDescriptorsVisitor >> rootDescriptor [

	^ rootDescriptor
]

{ #category : #accessing }
SlotDescriptorsVisitor >> rootDescriptor: anObject [

	rootDescriptor := anObject
]

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
SlotDescriptorsVisitor >> visitClass: aClass [

	^ self visitBehavior: aClass
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
SlotDescriptorsVisitor >> visitDictionary: aDictionary [

	^ self visitObject: aDictionary
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

	^ (self visitObject: aFileReference) , { 
		  #fullName asSlotDescriptor.
		  #contents asSlotDescriptor.
		  #size asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (self visitObject: aFraction) , { 
		  #floor asSlotDescriptor.
		  "#asFractionWrtFloor asSlotDescriptor."
		  (#asPythagoreanTriple asSlotDescriptor
			   noHeader;
			   inline: true;
			   quote: [ :anArray | anArray asShapeSlotsDfsTree: self ]).
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
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]).
					   (#inverseMultiplicativeOfb asSlotDescriptor
						    inline: true;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]) } ]
			   ifFalse: [ 
				   { 
					   (#asShapeDividendOverGCD asSlotDescriptor
						    inline: true;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]).
					   (#asShapeDivisorOverGCD asSlotDescriptor
						    inline: true;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]) } ])
	".

		  #divisibility asSlotDescriptor"
	"(#asShapeDiophantineEquation asSlotDescriptor
			   inline: true;
			   quote)."
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (self visitObject: aHeap) , { (#asShapeValueTree asSlotDescriptor
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

	^ (self visitObject: aPoint)
	  , { #asShapeWrtOrigin asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (self visitObject: aPointArray)
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

	^ (self visitObject: aShape)
	  , { #asShapeQuoted asSlotDescriptor quote }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom) , { (#asShapeScatter asSlotDescriptor
		   inline: true;
		   quote) }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitStack: aStack [

	^ { #firstLink asSlotDescriptor }
]

{ #category : #visiting }
SlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { #value asSlotDescriptor } , (self visitLink: aValueLink)
]
