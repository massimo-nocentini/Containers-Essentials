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
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #copying }
CTSlotDescriptorsVisitor >> collect: aBlock [

	^ CTSlotDescriptorsVisitorCollect basicNew
		  slotDescriptorsVisitor: self;
		  collectBlock: aBlock;
		  initialize;
		  yourself
]

{ #category : #initialization }
CTSlotDescriptorsVisitor >> initialize [

	super initialize.

	self rootDescriptor: (self newSlotDescriptorSelector: #yourself)
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorFollowerOf: descriptor then: block [

	^ CTFollowerSlotDescriptor new
		  descriptor: descriptor;
		  follower: block;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorInstVarName: aVarName [

	^ CTInstVarSlotDescriptor new
		  selector: aVarName;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorSelector: aSelector [

	^ CTSelectorSlotDescriptor new
		  selector: aSelector;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorString: aSelector accessor: aBlock [

	^ CTBlockSlotDescriptor new
		  selector: aSelector;
		  accessor: aBlock;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorYourself [

	^ self newSlotDescriptorSelector: #yourself
]

{ #category : #copying }
CTSlotDescriptorsVisitor >> postCopy [

	super postCopy.

	self rootDescriptor: rootDescriptor copy
]

{ #category : #accessing }
CTSlotDescriptorsVisitor >> rootDescriptor [

	^ rootDescriptor copy
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
		  (self newSlotDescriptorSelector: #asArrayOfLinks).
		  ((self newSlotDescriptorSelector: #asShapeMod2)
			   enablePredicate: [ 
				   aMatrix allSatisfy: [ :each | each isInteger ] ];
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray: anArray [

	^ (1 to: anArray size) collect: [ :index | 
		  self
			  newSlotDescriptorString: index asString
			  accessor: [ anArray at: index ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBag: aBag [

	^ { 
		  (self newSlotDescriptorSelector: #associations).

		  ((self newSlotDescriptorSelector: #asShapeHistogram)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBehavior: aBehavior [

	^ { 
		  (self newSlotDescriptorSelector: #name) inline.
		  (self newSlotDescriptorSelector: #class).
		  (self newSlotDescriptorSelector: #superclass).
		  (self newSlotDescriptorSelector: #instanceCount).
		  ((self newSlotDescriptorSelector: #traits) enablePredicate: [ 
			   aBehavior traits isNotEmpty ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBlockClosure: aBlock [

	^ aBlock sourceNode allVariables flatCollect: [ :aRBVariable | 
		  (aBlock outerContext lookupVar: aRBVariable name)
			  ifNil: [ #(  ) ]
			  ifNotNil: [ :var | 
				  { (self
					   newSlotDescriptorString: var name
					   accessor: [ var ]) } ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitByteArray: aByteArray [

	^ { 
		  (self newSlotDescriptorSelector: #hex).
		  (self newSlotDescriptorSelector: #asString).
		  (self newSlotDescriptorSelector: #asArray).
		  ((self
			    newSlotDescriptorString: #asShapeBitsDump:
			    accessor: [ aByteArray ])
			   inline;
			   quoteUsingSelector) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitClass: aClass [

	^ self visitBehavior: aClass
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitColor: aColor [

	^ (self visitObject: aColor)
	  , { ((self newSlotDescriptorSelector: #asShapeColoredBox)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCompiledMethod: aCompiledMethod [

	^ { 
		  (self newSlotDescriptorSelector: #methodClassName).
		  (self newSlotDescriptorSelector: #selector).
		  (self newSlotDescriptorSelector: #formattedCode) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitContext: aContext [

	^ { 
		  (self newSlotDescriptorSelector: #home).
		  (self newSlotDescriptorSelector: #activeHome).
		  (self newSlotDescriptorSelector: #outerContext).
		  (self newSlotDescriptorSelector: #sender).
		  (self newSlotDescriptorSelector: #receiver) inline.
		  (self newSlotDescriptorSelector: #selector).
		  (self newSlotDescriptorSelector: #closure) inline.
		  (self newSlotDescriptorSelector: #pc).
		  (self newSlotDescriptorSelector: #stackPtr) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDateAndTime: aDateAndTime [

	^ (self visitObject: aDateAndTime) , { 
		  (self newSlotDescriptorSelector: #asTimeZoneString) inline.
		  (self newSlotDescriptorSelector: #asISO8601String).
		  (self newSlotDescriptorSelector: #asLocalStringYMDHM) inline.
		  (self newSlotDescriptorSelector: #dayOfWeekName).
		  (self newSlotDescriptorSelector: #monthName).
		  (self newSlotDescriptorSelector: #month).
		  (self newSlotDescriptorSelector: #dayOfMonth).
		  (self newSlotDescriptorSelector: #year).
		  (self newSlotDescriptorSelector: #asTimeString) inline }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDictionary: aDictionary [

	^ self visitObject: aDictionary
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDoubleLink: aDoubleLink [

	^ { 
		  (self newSlotDescriptorSelector: #previousLink).
		  (self newSlotDescriptorSelector: #value).
		  (self newSlotDescriptorSelector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitDuration: aDuration [

	^ { 
		  (self newSlotDescriptorSelector: #asDays).
		  (self newSlotDescriptorSelector: #asHours).
		  (self newSlotDescriptorSelector: #asMinutes).
		  (self newSlotDescriptorSelector: #asSeconds).
		  (self newSlotDescriptorSelector: #asMilliSeconds).
		  (self newSlotDescriptorSelector: #asMicroseconds).
		  (self newSlotDescriptorSelector: #asNanoSeconds).
		  (self newSlotDescriptorSelector: #asStringDHHMMSSµ) inline.
		  (self newSlotDescriptorSelector: #asStringScaledUptoHours) inline }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitExternalAddress: anExternalAddress [

	^ { (self newSlotDescriptorSelector: #printString) inline }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFileReference: aFileReference [

	^ (self visitObject: aFileReference) , { 
		  (self newSlotDescriptorSelector: #fullName).
		  (self newSlotDescriptorSelector: #contents).
		  (self newSlotDescriptorSelector: #size) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitFraction: aFraction [

	^ (self visitObject: aFraction) , { 
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
CTSlotDescriptorsVisitor >> visitGreatestCommonDivisor: aGreatestCommonDivisor [

	^ { 
		  (self newSlotDescriptorSelector: #a).
		  (self newSlotDescriptorSelector: #b).
		  (self newSlotDescriptorSelector: #value).
		  (self newSlotDescriptorSelector: #asString) inline.
		  (self newSlotDescriptorSelector: #equations).
		  (self newSlotDescriptorSelector: #point).
		  (self newSlotDescriptorSelector: #asStringDiophantineEquation)
			  inline.
		  ((self newSlotDescriptorSelector: #inverseMultiplicativeOfa)
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #inverseMultiplicativeOfb)
			   enablePredicate: [ aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #asShapeDividendOverGCD)
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #asShapeDivisorOverGCD)
			   enablePredicate: [ aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker | 
				   anObject asShapeSlotsDfsTree: aDfsWalker ]) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitHeap: aHeap [

	| followedSlotDescriptor |
	followedSlotDescriptor := (self
		                           newSlotDescriptorString:
		                           #asShapeValuesHorizontalTree:
		                           accessor: [ aHeap ]) quoteUsingSelector.

	followedSlotDescriptor := self
		                          newSlotDescriptorFollowerOf:
		                          followedSlotDescriptor
		                          then: [ 
			                          | size |
			                          size := aHeap size.

			                          { 
				                          (self newSlotDescriptorSelector:
					                           #yourself) noInline.
				                          (self
					                           newSlotDescriptorFollowerOf:
						                           ((self newSlotDescriptorSelector:
								                             #size)
							                            noInline;
							                            headerWithClass)
					                           then: [ 
						                           | printString |
						                           printString := size printString.
						                           { 
							                           self newSlotDescriptorYourself
								                           noInline.
							                           (self
								                            newSlotDescriptorFollowerOf:
									                            (self
										                             newSlotDescriptorString:
										                             #somePrintString
										                             accessor: [ printString ])
								                            then: [ 
									                            { 
										                            self newSlotDescriptorYourself.
										                            ((self 
											                              newSlotDescriptorSelector:
												                              #size)
											                             noInline;
											                             headerWithClass) } ]) } ]).
				                          (self
					                           newSlotDescriptorFollowerOf:
					                           (self newSlotDescriptorSelector:
						                            #asShapeValuesHorizontalTree) quote
					                           then: [ 
						                           { 
							                           (self newSlotDescriptorSelector:
								                            #array).
							                           self newSlotDescriptorYourself } ]) } ].

	^ (self visitObject: aHeap) , { 
		  followedSlotDescriptor.
		  ((self newSlotDescriptorSelector: #asShapeValuesHorizontalTree)
			   inline;
			   quote).
		  ((self
			    newSlotDescriptorString: #asShapeBubblesHorizontalTree:
			    accessor: [ aHeap ])
			   enablePredicate: [ aHeap allSatisfy: [ :each | each isNumber ] ];
			   inline;
			   quoteUsingSelector) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitInteger: anInteger [

	^ self visitObject: anInteger
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitLink: aLink [

	^ { (self newSlotDescriptorSelector: #nextLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitObject: anObject [

	^ anObject class allInstVarNames collect: [ :varNameSymbol | 
		  self newSlotDescriptorInstVarName: varNameSymbol ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPoint: aPoint [

	^ (self visitObject: aPoint)
	  , { (self newSlotDescriptorSelector: #π) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitPointArray: aPointArray [

	^ (self visitObject: aPointArray)
	  , { (self newSlotDescriptorSelector: #asShapeDots) quote }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitProcess: aProcess [

	^ self visitObject: aProcess
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitQuoRemComplementary: aQuoRemComplementary [

	^ { 
		  (self newSlotDescriptorSelector: #a).
		  (self newSlotDescriptorSelector: #b).
		  (self newSlotDescriptorSelector: #quo).
		  (self newSlotDescriptorSelector: #rem).
		  (self newSlotDescriptorSelector: #asString) inline.
		  ((self newSlotDescriptorSelector: #asShapeDots)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSArcLengthParametricLine: aLine [

	^ (self visitRSParametricLine: aLine)
	  , { (self newSlotDescriptorSelector: #line) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSBoundingShape: aShape [

	^ (self visitObject: aShape)
	  , { (self newSlotDescriptorSelector: #asShapeQuoted) quote }
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
		  (self newSlotDescriptorSelector: #size).
		  (self newSlotDescriptorSelector: #arcLength).
		  ((self newSlotDescriptorSelector: #asShapeParamDistanceScatter)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSParametricLine: aLine [

	^ { 
		  (self newSlotDescriptorSelector: #controlPointsSize).
		  (self newSlotDescriptorSelector: #parameterization).
		  ((self newSlotDescriptorSelector: #asGroupWithControlNet) 
			   quoteGroupWithModel: aLine) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRSdeCasteljauLine: aLine [

	^ (self visitRSParametricLine: aLine)
	  , { ((self newSlotDescriptorSelector: #asGroupBernsteinBase)
			   inline;
			   quoteGroupWithModel: aLine) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitRandom: aRandom [

	^ (self visitObject: aRandom)
	  , { ((self newSlotDescriptorSelector: #asShapeScatter)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitStack: aStack [

	^ { (self newSlotDescriptorSelector: #firstLink) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitValueLink: aValueLink [

	^ { (self newSlotDescriptorSelector: #value) }
	  , (self visitLink: aValueLink)
]
