"
I am a visitor of more common objects in order to return a collection of slot descriptors
corresponding to their classes, respectively.
"
Class {
	#name : #CTSlotDescriptorsVisitor,
	#superclass : #Object,
	#instVars : [
		'rootDescriptor'
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

{ #category : #copying }
CTSlotDescriptorsVisitor >> postCopy [

	super postCopy.

	self rootDescriptor: rootDescriptor copy
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
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBehavior: aBehavior [

	| traits |
	traits := aBehavior traits
		          ifEmpty: [ {  } ]
		          ifNotEmpty: [ { #traits asSlotDescriptor } ].

	^ { 
		  #name asSlotDescriptor inline.
		  #class asSlotDescriptor.
		  #superclass asSlotDescriptor.
		  "#mcType asSlotDescriptor."
		  #instanceCount asSlotDescriptor } , traits
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
			   inline;
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
			   inline;
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

		  #receiver asSlotDescriptor inline.

		  #selector asSlotDescriptor.
		  #closure asSlotDescriptor inline.

		  "(#arguments asSlotDescriptor inline: true)."
		  #pc asSlotDescriptor.
		  #stackPtr asSlotDescriptor }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

	^ (self visitObject: aDateAndTime) , { 
		  #asTimeZoneString asSlotDescriptor inline.
		  #asISO8601String asSlotDescriptor.
		  #asLocalStringYMDHM asSlotDescriptor inline.
		  #dayOfWeekName asSlotDescriptor.
		  #monthName asSlotDescriptor.
		  #month asSlotDescriptor.
		  #dayOfMonth asSlotDescriptor.
		  "		  ('Day of year' -> [ :anObj | anObj dayOfYear ])."
		  #year asSlotDescriptor.
		  #asTimeString asSlotDescriptor inline }
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
		  #asStringDHHMMSSµ asSlotDescriptor inline.
		  #asStringScaledUptoHours asSlotDescriptor inline }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitExternalAddress: anExternalAddress [

	^ { #printString asSlotDescriptor inline }
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
			   inline;
			   quote: [ :anArray | anArray asShapeSlotsDfsTree: self ]).
		  (#asShapeOnUnitCircle asSlotDescriptor
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  #asString asSlotDescriptor inline.
		  #equations asSlotDescriptor.
		  #point asSlotDescriptor.
		  #asStringDiophantineEquation asSlotDescriptor inline }
	  , (aGreatestCommonDivisor = 1
			   ifTrue: [ 
				   { 
					   (#inverseMultiplicativeOfa asSlotDescriptor
						    inline;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]).
					   (#inverseMultiplicativeOfb asSlotDescriptor
						    inline;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]) } ]
			   ifFalse: [ 
				   { 
					   (#asShapeDividendOverGCD asSlotDescriptor
						    inline;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]).
					   (#asShapeDivisorOverGCD asSlotDescriptor
						    inline;
						    quote: [ :anObject | anObject asShapeSlotsDfsTree: self ]) } ])
	".

		  #divisibility asSlotDescriptor"
	"(#asShapeDiophantineEquation asSlotDescriptor
			   inline: true;
			   quote)."
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (self visitObject: aHeap)
	  , { (#asShapeValuesHorizontalTree asSlotDescriptor
			   inline;
			   quote) } , ((aHeap allSatisfy: [ :each | each isNumber ])
		   ifTrue: [ 
			   { (#asShapeBubblesHorizontalTree asSlotDescriptor
				    inline;
				    quote) } ]
		   ifFalse: [ Array empty ])
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
CTSlotDescriptorsVisitor >> visitProcess: aProcess [

	^ self visitObject: aProcess
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
			   inline;
			   quote)."
		  #asString asSlotDescriptor inline.
		  (#asShapeDots asSlotDescriptor
			   inline;
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
			  inline;
			  quote ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom) , { (#asShapeScatter asSlotDescriptor
		   inline;
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
