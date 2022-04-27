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

	self rootDescriptor: (self newSlotDescriptorSelector
			 selector: #yourself;
			 yourself)
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorInstVarName [

	^ CTInstVarSlotDescriptor new
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorLabel: aSelector accessor: aBlock [

	^ CTBlockSlotDescriptor new
		  selector: aSelector;
		  accessor: aBlock;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorSelector [

	^ CTSelectorSlotDescriptor new
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
		  (self newSlotDescriptorSelector
			   selector: #asArrayOfLinks;
			   yourself).
		  (self newSlotDescriptorSelector
			   selector: #asShapeMod2;
			   enablePredicate: [ 
				   aMatrix allSatisfy: [ :each | each isInteger ] ];
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray: anArray [

	^ anArray withIndexCollect: [ :each :index | 
		  self newSlotDescriptorLabel: index asString accessor: [ each ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBag: aBag [

	^ { 
		  (self newSlotDescriptorSelector
			   selector: #associations;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #asShapeHistogram;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBehavior: aBehavior [

	^ { 
		  (self newSlotDescriptorSelector
			   selector: #name;
			   inline;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #class;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #superclass;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #instanceCount;
			   yourself).

		  (self newSlotDescriptorSelector
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
				  { (self
					   newSlotDescriptorLabel: var name
					   accessor: [ var ]) } ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitByteArray: aByteArray [

	^ { 
		  (self newSlotDescriptorSelector
			   selector: #hex;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #asString;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #asArray;
			   yourself).

		  (self newSlotDescriptorSelector
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

	^ (self visitObject: aColor) , { (self newSlotDescriptorSelector
		   selector: #asShapeColoredBox;
		   inline;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCompiledMethod: aCompiledMethod [

	^ { 
		  (self newSlotDescriptorSelector
			   selector: #methodClassName;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #selector;
			   yourself).

		  (self newSlotDescriptorSelector
			   selector: #formattedCode;
			   yourself) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitContext: aContext [

	^ { 
		  (self newSlotDescriptorSelector selector: #home).
		  (self newSlotDescriptorSelector selector: #activeHome).
		  (self newSlotDescriptorSelector selector: #outerContext).
		  (self newSlotDescriptorSelector selector: #sender).
		  (self newSlotDescriptorSelector
			   selector: #receiver;
			   inline).
		  (self newSlotDescriptorSelector selector: #selector).
		  (self newSlotDescriptorSelector
			   selector: #closure;
			   inline).
		  (self newSlotDescriptorSelector selector: #pc).
		  (self newSlotDescriptorSelector selector: #stackPtr) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

	^ (self visitObject: aDateAndTime) , { 
		  (self newSlotDescriptorSelector
			   selector: #asTimeZoneString;
			   inline).
		  (self newSlotDescriptorSelector selector: #asISO8601String).
		  (self newSlotDescriptorSelector
			   selector: #asLocalStringYMDHM;
			   inline).
		  (self newSlotDescriptorSelector selector: #dayOfWeekName).
		  (self newSlotDescriptorSelector selector: #monthName).
		  (self newSlotDescriptorSelector selector: #month).
		  (self newSlotDescriptorSelector selector: #dayOfMonth).
		  (self newSlotDescriptorSelector selector: #year).
		  (self newSlotDescriptorSelector
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
		  (self newSlotDescriptorSelector selector: #previousLink).
		  (self newSlotDescriptorSelector selector: #value).
		  (self newSlotDescriptorSelector selector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDuration: aDuration [

	^ { 
		  (self newSlotDescriptorSelector selector: #asDays).
		  (self newSlotDescriptorSelector selector: #asHours).
		  (self newSlotDescriptorSelector selector: #asMinutes).
		  (self newSlotDescriptorSelector selector: #asSeconds).
		  (self newSlotDescriptorSelector selector: #asMilliSeconds).
		  (self newSlotDescriptorSelector selector: #asMicroseconds).
		  (self newSlotDescriptorSelector selector: #asNanoSeconds).
		  (self newSlotDescriptorSelector
			   selector: #asStringDHHMMSSµ;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asStringScaledUptoHours;
			   inline) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitExternalAddress: anExternalAddress [

	^ { (self newSlotDescriptorSelector
		   selector: #printString;
		   inline) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFileReference: aFileReference [

	^ (self visitObject: aFileReference) , { 
		  (self newSlotDescriptorSelector selector: #fullName).
		  (self newSlotDescriptorSelector selector: #contents).
		  (self newSlotDescriptorSelector selector: #size) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (self visitObject: aFraction) , { 
		  (self newSlotDescriptorSelector selector: #floor).
		  (self newSlotDescriptorSelector selector: #asFloat).
		  (self newSlotDescriptorSelector
			   selector: #asPythagoreanTriple;
			   inline;
			   noHeader;
			   quote: [ :aTriple :aDfsWalker | 
				   aTriple asShapeSlotsDfsTree: aDfsWalker ]).
		  (self newSlotDescriptorSelector
			   selector: #asShapeOnUnitCircle;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

	^ { 
		  (self newSlotDescriptorSelector selector: #a).
		  (self newSlotDescriptorSelector selector: #b).
		  (self newSlotDescriptorSelector selector: #value).
		  (self newSlotDescriptorSelector
			   selector: #asString;
			   inline).
		  (self newSlotDescriptorSelector selector: #equations).
		  (self newSlotDescriptorSelector selector: #point).
		  (self newSlotDescriptorSelector
			   selector: #asStringDiophantineEquation;
			   inline).

		  (self newSlotDescriptorSelector
			   selector: #inverseMultiplicativeOfa;
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptorSelector
			   selector: #inverseMultiplicativeOfb;
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptorSelector
			   selector: #asShapeDividendOverGCD;
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).

		  (self newSlotDescriptorSelector
			   selector: #asShapeDivisorOverGCD;
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitHeap: aHeap [

	^ (self visitObject: aHeap) , { 
		  ((self
			    newSlotDescriptorLabel: #asShapeValuesHorizontalTree:
			    accessor: [ aHeap ]) quote: [ :anObject :aDfsWalker | 
			   anObject asShapeValuesHorizontalTree: aDfsWalker ]).

		  (self newSlotDescriptorSelector
			   selector: #asShapeValuesHorizontalTree;
			   inline;
			   quote).

		  ((self
			    newSlotDescriptorLabel: #asShapeBubblesHorizontalTree:
			    accessor: [ aHeap ])
			   enablePredicate: [ aHeap allSatisfy: [ :each | each isNumber ] ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeBubblesHorizontalTree: aDfsWalker ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitInteger: anInteger [

	^ self visitObject: anInteger
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitLink: aLink [

	^ { (self newSlotDescriptorSelector selector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitObject: anObject [

	^ anObject class allInstVarNames collect: [ :varNameSymbol | 
		  self newSlotDescriptorInstVarName selector: varNameSymbol ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPoint: aPoint [

	^ (self visitObject: aPoint)
	  , { (self newSlotDescriptorSelector selector: #π) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (self visitObject: aPointArray) , { (self newSlotDescriptorSelector
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
		  (self newSlotDescriptorSelector selector: #a).
		  (self newSlotDescriptorSelector selector: #b).
		  (self newSlotDescriptorSelector selector: #quo).
		  (self newSlotDescriptorSelector selector: #rem).
		  (self newSlotDescriptorSelector
			   selector: #asString;
			   inline).
		  (self newSlotDescriptorSelector
			   selector: #asShapeDots;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSArcLengthParametricLine: aLine [

	^ (self visitRSParametricLine: aLine)
	  , { (self newSlotDescriptorSelector selector: #line) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSBoundingShape: aShape [

	^ (self visitObject: aShape) , { (self newSlotDescriptorSelector
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
		  (self newSlotDescriptorSelector selector: #size).
		  (self newSlotDescriptorSelector selector: #arcLength).
		  (self newSlotDescriptorSelector
			   selector: #asShapeParamDistanceScatter;
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSParametricLine: aLine [

	^ { 
		  (self newSlotDescriptorSelector selector: #controlPointsSize).
		  (self newSlotDescriptorSelector selector: #parameterization).
		  (self newSlotDescriptorSelector
			   selector: #asGroupWithControlNet;
			   quote: [ :aGroup :aDfsWalker | aGroup asShapeFor: aLine ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSdeCasteljauLine: aLine [

	^ (self visitRSParametricLine: aLine)
	  , { (self newSlotDescriptorSelector
			   selector: #asGroupBernsteinBase;
			   inline;
			   quote: [ :aGroup :aDfsWalker | aGroup asShapeFor: aLine ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom) , { (self newSlotDescriptorSelector
		   selector: #asShapeScatter;
		   inline;
		   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitStack: aStack [

	^ { (self newSlotDescriptorSelector selector: #firstLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { (self newSlotDescriptorSelector selector: #value) }
	  , (self visitLink: aValueLink)
]
