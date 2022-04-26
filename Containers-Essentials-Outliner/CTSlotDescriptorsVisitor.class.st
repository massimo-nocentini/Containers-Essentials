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
		  collectBlock: aBlock;
		  initialize;
		  yourself
]

{ #category : #initialization }
CTSlotDescriptorsVisitor >> initialize [

	super initialize.

	self rootDescriptor: (self newSlotDescriptor
			 selector: #yourself;
			 yourself)
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptor [

	^ CTBlockSlotDescriptor new
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

	^ (self visitObject: aMatrix) allButFirst , { 
		  (self newSlotDescriptor
			   selector: #asArrayOfLinks;
			   yourself).
		  (self newSlotDescriptor
			   selector: #asShapeMod2;
			   enablePredicate: [ 
				   aMatrix allSatisfy: [ :each | each isInteger ] ];
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray: anArray [

	^ anArray withIndexCollect: [ :each :index | 
		  self newSlotDescriptor
			  selector: index asString;
			  blockClosure: [ :anObj :aDfsWalker | each ];
			  yourself ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBag: aBag [

	^ { 
		  (self newSlotDescriptor
			   selector: #associations;
			   yourself).

		  (self newSlotDescriptor
			   selector: #asShapeHistogram;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBehavior: aBehavior [

	^ { 
		  (self newSlotDescriptor
			   selector: #name;
			   inline;
			   yourself).

		  (self newSlotDescriptor
			   selector: #class;
			   yourself).

		  (self newSlotDescriptor
			   selector: #superclass;
			   yourself).

		  (self newSlotDescriptor
			   selector: #instanceCount;
			   yourself).

		  (self newSlotDescriptor
			   selector: #traits;
			   enablePredicate: [ aBehavior traits isNotEmpty ];
			   yourself) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBlockClosure: aBlock [

	^ aBlock sourceNode allVariables flatCollect: [ :aRBVariable | 
		  (aBlock outerContext lookupVar: aRBVariable name)
			  ifNil: [ #(  ) ]
			  ifNotNil: [ :var | 
				  { (self newSlotDescriptor
					   selector: var name;
					   blockClosure: [ :anObj :aDfsWalker | var value ]) } ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitByteArray: aByteArray [

	^ { 
		  (self newSlotDescriptor
			   selector: #hex;
			   yourself).

		  (self newSlotDescriptor
			   selector: #asString;
			   yourself).

		  (self newSlotDescriptor
			   selector: #asArray;
			   yourself).

		  (self newSlotDescriptor
			   selector: #asShapeBitsDump:;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitClass: aClass [

	^ self visitBehavior: aClass
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitColor: aColor [

	^ (self visitObject: aColor) , { (self newSlotDescriptor
		   selector: #asShapeColoredBox;
		   inline;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCompiledMethod: aCompiledMethod [

	^ { 
		  (self newSlotDescriptor
			   selector: #methodClassName;
			   yourself).

		  (self newSlotDescriptor
			   selector: #selector;
			   yourself).

		  (self newSlotDescriptor
			   selector: #formattedCode;
			   yourself) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitContext: aContext [

	^ { 
		  (self newSlotDescriptor selector: #home).
		  (self newSlotDescriptor selector: #activeHome).
		  (self newSlotDescriptor selector: #outerContext).
		  (self newSlotDescriptor selector: #sender).
		  (self newSlotDescriptor
			   selector: #receiver;
			   inline).
		  (self newSlotDescriptor selector: #selector).
		  (self newSlotDescriptor
			   selector: #closure;
			   inline).
		  (self newSlotDescriptor selector: #pc).
		  (self newSlotDescriptor selector: #stackPtr) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

	^ (self visitObject: aDateAndTime) , { 
		  (self newSlotDescriptor
			   selector: #asTimeZoneString;
			   inline).
		  (self newSlotDescriptor selector: #asISO8601String).
		  (self newSlotDescriptor
			   selector: #asLocalStringYMDHM;
			   inline).
		  (self newSlotDescriptor selector: #dayOfWeekName).
		  (self newSlotDescriptor selector: #monthName).
		  (self newSlotDescriptor selector: #month).
		  (self newSlotDescriptor selector: #dayOfMonth).
		  (self newSlotDescriptor selector: #year).
		  (self newSlotDescriptor
			   selector: #asTimeString;
			   inline) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDictionary: aDictionary [

	^ self visitObject: aDictionary
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDoubleLink: aDoubleLink [

	^ { 
		  (self newSlotDescriptor selector: #previousLink).
		  (self newSlotDescriptor selector: #value).
		  (self newSlotDescriptor selector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDuration: aDuration [

	^ { 
		  (self newSlotDescriptor selector: #asDays).
		  (self newSlotDescriptor selector: #asHours).
		  (self newSlotDescriptor selector: #asMinutes).
		  (self newSlotDescriptor selector: #asSeconds).
		  (self newSlotDescriptor selector: #asMilliSeconds).
		  (self newSlotDescriptor selector: #asMicroseconds).
		  (self newSlotDescriptor selector: #asNanoSeconds).
		  (self newSlotDescriptor
			   selector: #asStringDHHMMSSµ;
			   inline).
		  (self newSlotDescriptor
			   selector: #asStringScaledUptoHours;
			   inline) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitExternalAddress: anExternalAddress [

	^ { (self newSlotDescriptor
		   selector: #printString;
		   inline) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFileReference: aFileReference [

	^ (self visitObject: aFileReference) , { 
		  (self newSlotDescriptor selector: #fullName).
		  (self newSlotDescriptor selector: #contents).
		  (self newSlotDescriptor selector: #size) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (self visitObject: aFraction) , { 
		  (self newSlotDescriptor selector: #floor).
		  (self newSlotDescriptor selector: #asFloat).
		  (self newSlotDescriptor
			   selector: #asPythagoreanTriple;
			   inline;
			   noHeader;
			   quote: [ :anObject :anArray :aDfsWalker | 
				   anArray asShapeSlotsDfsTree: aDfsWalker ]).
		  (self newSlotDescriptor
			   selector: #asShapeOnUnitCircle;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

	^ { 
		  (self newSlotDescriptor selector: #a).
		  (self newSlotDescriptor selector: #b).
		  (self newSlotDescriptor selector: #value).
		  (self newSlotDescriptor
			   selector: #asString;
			   inline).
		  (self newSlotDescriptor selector: #equations).
		  (self newSlotDescriptor selector: #point).
		  (self newSlotDescriptor
			   selector: #asStringDiophantineEquation;
			   inline).

		  (self newSlotDescriptor
			   selector: #inverseMultiplicativeOfa;
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :sourceObject :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptor
			   selector: #inverseMultiplicativeOfb;
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :sourceObject :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptor
			   selector: #asShapeDividendOverGCD;
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :sourceObject :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptor
			   selector: #asShapeDivisorOverGCD;
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :sourceObject :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (self visitObject: aHeap) , { 
		  (self newSlotDescriptor
			   selector: #asShapeValuesHorizontalTree:;
			   inline;
			   quote).

		  (self newSlotDescriptor
			   selector: #asShapeValuesHorizontalTree;
			   inline;
			   quote).

		  (self newSlotDescriptor
			   selector: #asShapeBubblesHorizontalTree:;
			   enablePredicate: [ aHeap allSatisfy: [ :each | each isNumber ] ];
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitInteger: anInteger [

	^ self visitObject: anInteger
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitLink: aLink [

	^ { (self newSlotDescriptor selector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitObject: anObject [

	^ anObject class allInstVarNames collect: [ :varNameSymbol | 
		  self newSlotDescriptor
			  selector: varNameSymbol;
			  blockClosure: [ :anObj :aDfsWalker | 
				  anObject instVarNamed: varNameSymbol ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPoint: aPoint [

	^ (self visitObject: aPoint)
	  , { (self newSlotDescriptor selector: #π) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (self visitObject: aPointArray) , { (self newSlotDescriptor
		   selector: #asShapeDots;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitProcess: aProcess [

	^ self visitObject: aProcess
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitQuoRemComplementary: aQuoRemComplementary [

	^ { 
		  (self newSlotDescriptor selector: #a).
		  (self newSlotDescriptor selector: #b).
		  (self newSlotDescriptor selector: #quo).
		  (self newSlotDescriptor selector: #rem).
		  (self newSlotDescriptor
			   selector: #asString;
			   inline).
		  (self newSlotDescriptor
			   selector: #asShapeDots;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSArcLengthParametricLine: aLine [

	^ (self visitRSParametricLine: aLine)
	  , { (self newSlotDescriptor selector: #line) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSBoundingShape: aShape [

	^ (self visitObject: aShape) , { (self newSlotDescriptor
		   selector: #asShapeQuoted;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSGroup: aGroup [

	^ (self visitArray: aGroup) collect: [ :each | 
		  each
			  inline;
			  quote ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSParameterization: aParameterization [

	^ { 
		  (self newSlotDescriptor selector: #size).
		  (self newSlotDescriptor selector: #arcLength).
		  (self newSlotDescriptor
			   selector: #asShapeParamDistanceScatter;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSParametricLine: aLine [

	^ { 
		  (self newSlotDescriptor selector: #controlPointsSize).
		  (self newSlotDescriptor selector: #parameterization).
		  (self newSlotDescriptor
			   selector: #asGroupWithControlNet;
			   quoteGroup) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSdeCasteljauLine: aLine [

	^ (self visitRSParametricLine: aLine) , { (self newSlotDescriptor
		   selector: #asGroupBernsteinBase;
		   inline;
		   quoteGroup) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom) , { (self newSlotDescriptor
		   selector: #asShapeScatter;
		   inline;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitStack: aStack [

	^ { (self newSlotDescriptor selector: #firstLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { (self newSlotDescriptor selector: #value) }
	  , (self visitLink: aValueLink)
]
