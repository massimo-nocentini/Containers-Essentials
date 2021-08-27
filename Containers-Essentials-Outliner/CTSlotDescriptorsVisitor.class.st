"
I am a visitor of more common objects in order to return a collection of slot descriptors
corresponding to their classes, respectively.
"
Class {
	#name : #CTSlotDescriptorsVisitor,
	#superclass : #Object,
	#instVars : [
		'rootDescriptor',
		'isOneToMany'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #copying }
CTSlotDescriptorsVisitor >> collect: aBlock [

	^ CTSlotDescriptorsVisitorCollect basicNew
		  slotDescriptorsContext: self;
		  blockClosure: aBlock;
		  initialize;
		  yourself
]

{ #category : #initialization }
CTSlotDescriptorsVisitor >> initialize [

	super initialize.
	
	self rootDescriptor: #yourself asSlotDescriptor
]

{ #category : #accessing }
CTSlotDescriptorsVisitor >> rootDescriptor [

	^ rootDescriptor
]

{ #category : #accessing }
CTSlotDescriptorsVisitor >> rootDescriptor: anObject [

	rootDescriptor := anObject
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visit: anObject [

	^ anObject acceptSlotDescriptorsVisitor: self
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray2D: aMatrix [

	^ (self visitObject: aMatrix) allButFirst
	  , { #asArrayOfLinks asSlotDescriptor }
	  , ((aMatrix allSatisfy: [ :each | each isInteger ])
			   ifTrue: [ { #asShapeMod2 asSlotDescriptor quote } ]
			   ifFalse: [ Array empty ])
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray: anArray [

	^ anArray withIndexCollect: [ :each :index | 
		  index asString asSlotDescriptor blockClosure: [ each ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBag: aBag [

	^ { 
		  #associations asSlotDescriptor.
		  (#asShapeHistogram asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBehavior: aBehavior [

	^ { 
		  (#name asSlotDescriptor inline: true).
		  #class asSlotDescriptor.
		  #superclass asSlotDescriptor.
		  #typeOfClass asSlotDescriptor.
		  #instanceCount asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBlockClosure: aBlock [

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
CTSlotDescriptorsVisitor >> visitByteArray: aByteArray [

	^ { 
		  #hex asSlotDescriptor.
		  #asString asSlotDescriptor.
		  #asArray asSlotDescriptor.
		  (#asShapeBitsDump asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitClass: aClass [

	^ self visitBehavior: aClass
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitColor: aColor [

	^ (self visitObject: aColor)
	  , { (#asShapeColoredBox asSlotDescriptor
			   inline: true;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCompiledMethod: aCompiledMethod [

	^ { 
		  #methodClassName asSlotDescriptor.
		  #selector asSlotDescriptor.
		  #formattedCode asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitContext: aContext [

	^ { 
		  #home asSlotDescriptor.
		  #activeHome asSlotDescriptor.
		  #outerContext asSlotDescriptor.
		  #sender asSlotDescriptor.

		  (#receiver asSlotDescriptor inline: true).

		  #selector asSlotDescriptor.
		  (#closure asSlotDescriptor inline: true).

		  "(#arguments asSlotDescriptor inline: true)."
		  #pc asSlotDescriptor.
		  #stackPtr asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

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
CTSlotDescriptorsVisitor >> visitDictionary: aDictionary [

	^ self visitObject: aDictionary
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDoubleLink: aDoubleLink [

	^ { 
		  #previousLink asSlotDescriptor.
		  #value asSlotDescriptor.
		  #nextLink asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDuration: aDuration [

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
CTSlotDescriptorsVisitor >> visitExternalAddress: anExternalAddress [

	^  { (#printString asSlotDescriptor inline: true) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFileReference: aFileReference [

	^ (self visitObject: aFileReference) , { 
		  #fullName asSlotDescriptor.
		  #contents asSlotDescriptor.
		  #size asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (self visitObject: aFraction) , { 
		  #floor asSlotDescriptor.
		  #asFloat asSlotDescriptor.
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
CTSlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

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
CTSlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (self visitObject: aHeap) , { (#asShapeValueTree asSlotDescriptor
		   inline: true;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitInteger: anInteger [

	^ self visitObject: anInteger
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitLink: aLink [

	^ { #nextLink asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitObject: anObject [

	^ anObject class allInstVarNames collect: [ :varName | 
		  varName asSlotDescriptor instVarNameHasBeenGiven ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPoint: aPoint [

	^ (self visitObject: aPoint) , { 
		  #π asSlotDescriptor.
		  #asShapeWrtOrigin asSlotDescriptor quote }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (self visitObject: aPointArray)
	  , { #asShapeDots asSlotDescriptor quote }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitQuoRemComplementary: aQuoRemComplementary [

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
CTSlotDescriptorsVisitor >> visitRSBoundingShape: aShape [

	^ (self visitObject: aShape)
	  , { #asShapeQuoted asSlotDescriptor quote }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSGroup: aGroup [

	^ (self visitArray: aGroup) collect: [ :each | 
		  each
			  inline: true;
			  quote ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom) , { (#asShapeScatter asSlotDescriptor
		   inline: true;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitStack: aStack [

	^ { #firstLink asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { #value asSlotDescriptor } , (self visitLink: aValueLink)
]