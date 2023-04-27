"
I am a visitor of more common objects in order to return a collection of slot descriptors
corresponding to their classes, respectively.
"
Class {
	#name : #CTSlotDescriptorsVisitor,
	#superclass : #Object,
	#instVars : [
		'rootDescriptor',
		'stack'
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

	^ self
		  newSlotDescriptorFollowersOf: descriptor
		  then: [ { block value } ]
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorFollowersOf: descriptor then: block [

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
CTSlotDescriptorsVisitor >> newSlotDescriptorString: aSelector constant: anObject [

	^ CTConstantSlotDescriptor new
		  selector: aSelector;
		  constant: anObject;
		  yourself
]

{ #category : #'instance creation' }
CTSlotDescriptorsVisitor >> newSlotDescriptorYourself [

	^ self newSlotDescriptorSelector: #yourself
]

{ #category : #adding }
CTSlotDescriptorsVisitor >> pop [

	^ stack
		  ifNil: [ Error signal: 'Cannot pop from an empty stack.' ]
		  ifNotNil: [ 
			  | value |
			  value := stack value.

			  stack := stack nextLink.

			  value ]
]

{ #category : #copying }
CTSlotDescriptorsVisitor >> postCopy [

	super postCopy.

	self rootDescriptor: rootDescriptor copy
]

{ #category : #adding }
CTSlotDescriptorsVisitor >> push: anObject [

	stack := ValueLink new
		         value: anObject;
		         nextLink: stack;
		         yourself
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
			   enablePredicate: [ :level |
				   aMatrix allSatisfy: [ :each | each isInteger ] ];
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitArray: anArray [

	^ anArray withIndexCollect: [ :each :index | 
		  self newSlotDescriptorString: index asString constant: each ]
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
		  (self newSlotDescriptorSelector: #name).
		  (self newSlotDescriptorSelector: #class).
		  (self newSlotDescriptorSelector: #superclass).
		  (self newSlotDescriptorSelector: #methodsCount).
		  (self newSlotDescriptorSelector: #instanceCount).
		  (self newSlotDescriptorSelector: #category).
		  ((self newSlotDescriptorSelector: #traits) enablePredicate: [
			   :level | aBehavior traits isNotEmpty ]).
		  ((self newSlotDescriptorSelector: #asFluidDefinitionShape)
			   inline;
			   quote) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitBlockClosure: aBlock [

	^ { (self newSlotDescriptorSelector: #compiledBlock) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitByteArray: aByteArray [

	^ { 
		  (self newSlotDescriptorSelector: #hex).
		  (self newSlotDescriptorSelector: #asString).
		  (self newSlotDescriptorSelector: #asArray).
		  ((self
			    newSlotDescriptorString: #asShapeBitsDump:
			    constant: aByteArray)
			   inline;
			   quoteUsingSelector) }
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCTKeyedValuedOrderedCollection: aKeyedCollection [

	^ aKeyedCollection keysAndValuesCollect: [ :key :value |
		  self newSlotDescriptorString: key constant: value ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCTNotebookKeyedValuedOrderedCollection: aKeyedCollection [

	| pangoMicVisitor |
	pangoMicVisitor := PangoMarkupMicrodownVisitor new.

	^ aKeyedCollection keysAndValuesCollect: [ :astNode :anObject |
		  astNode isCommentNode
			  ifTrue: [
				  | pango markup font mic |
				  font := LogicalFont fontconfigPharoSansSerifPointSize:
					          StandardFonts defaultFont pointSize.

				  mic := Microdown parse: astNode sourceCode allButFirstAndLast.

				  markup := pangoMicVisitor visit: mic.

				  pango := markup asRSPangoMarkupUsingFont: font.

				  (self newSlotDescriptorString: '' constant: pango)
					  inline;
					  leftAlignValueShapeWithinItsBox;
					  quote ]
			  ifFalse: [
				  | descriptor node isCommentedMessageSend o |
				  isCommentedMessageSend := astNode isMessage and: [
					                            astNode selector
					                            = #ignoreOutputBecause: ].

				  isCommentedMessageSend
					  ifTrue: [
						  node := astNode receiver.
						  o := anObject asDefaultShapeForWalker: nil ]
					  ifFalse: [
						  node := astNode.
						  o := anObject ].

				  descriptor := self
					                newSlotDescriptorString: node formattedCode
					                constant: o.

				  descriptor := descriptor varShapeBlock: [ :obj :walker :selector |
					                | text |
					                text := SpCodePresenter new
						                        beForScripting;
						                        text:
							                        selector fixEmptyLinesForPango
								                        replaceAllTabsWithSpacesForPango;
						                        textWithStyle.

					                RSComposite new
						                shapes: { (text asRSPangoTextUsingFont:
									                 (LogicalFont
										                  fontconfigPharoMonospacePointSize:
											                  StandardFonts codeFont pointSize)) };
						                yourself ].

				  isCommentedMessageSend ifTrue: [
					  descriptor := descriptor
						                leftAlignValueShapeWithinItsBox;
						                inline;
						                quote ].

				  descriptor ] ]
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
CTSlotDescriptorsVisitor >> visitCompiledCode: aCompiledCode [

	| i |
	i := 0.

	^ Array streamContents: [ :aStream | 
		  aCompiledCode literalsDo: [ :value | 
			  | descriptor |
			  i := i + 1.
			  descriptor := self
				                newSlotDescriptorString: i asString
				                constant: value.
			  aStream nextPut: descriptor ] ]
]

{ #category : #visiting }
CTSlotDescriptorsVisitor >> visitCompiledMethod: aCompiledMethod [

	^ {  }
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

	^ {  }
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
			   enablePredicate: [ :level | aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker |
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #inverseMultiplicativeOfb)
			   enablePredicate: [ :level | aGreatestCommonDivisor = 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker |
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #asShapeDividendOverGCD)
			   enablePredicate: [ :level | aGreatestCommonDivisor ~= 1 ];
			   inline;
			   quote: [ :anObject :aDfsWalker |
				   anObject asShapeSlotsDfsTree: aDfsWalker ]).
		  ((self newSlotDescriptorSelector: #asShapeDivisorOverGCD)
			   enablePredicate: [ :level | aGreatestCommonDivisor ~= 1 ];
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
		                           constant: aHeap) quoteUsingSelector.

	followedSlotDescriptor := self
		                          newSlotDescriptorFollowersOf:
		                          followedSlotDescriptor
		                          then: [
			                          | size anArray anotherArray |
			                          size := aHeap size.

			                          anArray := {
				                                     (self
					                                      newSlotDescriptorSelector:
					                                      #yourself) noInline.
				                                     (self
					                                      newSlotDescriptorFollowerOf:
						                                      ((self
							                                        newSlotDescriptorSelector:
								                                        #size)
							                                       noInline;
							                                       headerWithClass)
					                                      then: [
						                                      | printString |
						                                      printString := size
							                                                     printString.
						                                      {
							                                      self
								                                      newSlotDescriptorYourself
								                                      noInline.
							                                      (self
								                                       newSlotDescriptorFollowerOf:
								                                       (self
									                                        newSlotDescriptorString:
									                                        #somePrintString
									                                        constant: printString)
								                                       then: [
									                                       {
										                                       self
											                                       newSlotDescriptorYourself.
										                                       ((self
											                                         newSlotDescriptorSelector:
												                                         #size)
											                                        noInline;
											                                        headerWithClass) } ]) } ]).
				                                     (self
					                                      newSlotDescriptorFollowerOf:
					                                      (self
						                                       newSlotDescriptorSelector:
						                                       #asShapeValuesHorizontalTree)
						                                      quote
					                                      then: [
						                                      {
							                                      (self
								                                       newSlotDescriptorSelector:
								                                       #array).
							                                      self
								                                      newSlotDescriptorYourself } ]) }.

			                          anotherArray := { (self
				                                           newSlotDescriptorSelector:
				                                           #yourself) noInline }.

			                          {
				                          anArray.
				                          anotherArray } ].

	^ (self visitObject: aHeap) , {
		  followedSlotDescriptor.
		  ((self newSlotDescriptorSelector: #asShapeValuesHorizontalTree)
			   inline;
			   quote).
		  ((self
			    newSlotDescriptorString: #asShapeBubblesHorizontalTree:
			    constant: aHeap)
			   enablePredicate: [ :level |
				   aHeap allSatisfy: [ :each | each isNumber ] ];
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

	| slots |
	slots := OrderedCollection new.

	anObject class allInstVarNames do: [ :varNameSymbol |
		slots add: (self newSlotDescriptorInstVarName: varNameSymbol) ].

	"slots
		add: (self newSlotDescriptorSelector: #hash);
		add: (self newSlotDescriptorSelector: #identityHash);
		add: (self newSlotDescriptorSelector: #fullPrintString);
		add: ((self newSlotDescriptorSelector: #asStringPangoText)
				 inline;
				 quote).
"
	^ slots
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
