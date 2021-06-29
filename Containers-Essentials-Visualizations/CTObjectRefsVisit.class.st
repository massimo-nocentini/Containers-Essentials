Class {
	#name : #CTObjectRefsVisit,
	#superclass : #Object,
	#instVars : [
		'toShapes',
		'fromShapes',
		'maxLevel',
		'dfsClock',
		'sccShapeStack',
		'sccs',
		'rootObject',
		'metaColor',
		'metaFontSize',
		'metaExtent',
		'slotsBlock',
		'levels',
		'prototypeLabel',
		'quotedShapes'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
CTObjectRefsVisit >> addDraggableInteractionOnShape: mineShape [

	mineShape addInteraction: RSDraggable new
]

{ #category : #visiting }
CTObjectRefsVisit >> addHighlightInteractionOnShape: mineShape [

	mineShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
CTObjectRefsVisit >> addPopupInteractionOnShape: mineShape [

	mineShape addInteraction: (RSPopup new text: [ :each | 
			 String streamContents: [ :aStream | 
				 aStream
					 nextPutAll: 'BFS level: ';
					 nextPutAll: mineShape propertyDfsDepth asString;
					 cr;
					 nextPutAll: 'DFS timings: ';
					 nextPutAll: mineShape propertyDfsTimings asString;
					 cr;
					 nextPutAll: 'SCC lowlink: ';
					 nextPutAll: mineShape propertyDfsLowlink asString;
					 cr;
					 nextPutAll: 'SCC size: ';
					 nextPutAll: mineShape propertyDfsSCC size asString ] ])
]

{ #category : #visiting }
CTObjectRefsVisit >> boxShapeOf: value [

	^ RSBox new
		  model: value;
		  color: Color white;
		  cornerRadius: self radiusOrPadding;
		  withBorder;
		  addInteraction: RSHighlightable withLines;
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> classLabelShapeOf: anObject [

	| superClassShapes anObjectClass classes scale |
	anObjectClass := anObject class.
	classes := anObjectClass allSuperclasses reversed , { anObjectClass }.

	scale := NSScale ln
		         domain: (1 to: classes size);
		         range: (Array with: metaFontSize - 2 with: metaFontSize);
		         yourself.

	superClassShapes := classes collectWithIndex: [ :each :index | 
		                    RSLabel new
			                    text: each name;
			                    fontSize: metaFontSize;
			                    color: metaColor;
			                    when: RSMouseLeftClick
			                    do: [ :ev | each browse ];
			                    yourself: [ :labelShape | 
				                    each hasAbstractMethods ifTrue: [ 
						                    labelShape italic ] ] ].

	RSVerticalLineLayout new
		verticalGap: Float goldenRatio negated;
		alignLeft;
		on: superClassShapes.

	superClassShapes withIndexDo: [ :aShape :index | 
		| times offset |
		times := index - 1.
		offset := Float goldenRatio double * times.
		aShape position: aShape position x + offset @ aShape position y ].

	^ RSComposite new
		  model: anObjectClass;
		  shapes: superClassShapes;
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> createStronglyConnectedComponentIfNecessaryOnShape: mineShape [

	self
		assert: mineShape propertyDfsEntryTime isNotNil;
		assert: mineShape propertyDfsLowlink isNotNil.

	^ mineShape propertyDfsEntryTime = mineShape propertyDfsLowlink 
		  ifTrue: [ 
			  | scc |
			  scc := sccs add: OrderedCollection new.

			  [ 
			  sccShapeStack isNotNil and: [ 
				  sccShapeStack value propertyDfsEntryTime
				  >= mineShape propertyDfsEntryTime ] ] whileTrue: [ 
				  | shape |
				  shape := sccShapeStack value.
				  scc add: shape.
				  sccShapeStack := sccShapeStack nextLink.
				  shape
					  propertyDfsSCC: scc;
					  propertyDfsObjectStack: nil ].

			  self
				  assert: mineShape propertyDfsSCC == scc;
				  itself: scc ]
]

{ #category : #visiting }
CTObjectRefsVisit >> dfsClockTick [

	^ dfsClock := dfsClock + 1
]

{ #category : #visiting }
CTObjectRefsVisit >> dfsRecordTimingsOfShape: mineShape [

	mineShape propertyDfsTimings:
		mineShape propertyDfsEntryTime @ dfsClock.

	^ mineShape
]

{ #category : #visiting }
CTObjectRefsVisit >> forObject: anObject ithChild: i of: aParent level: level [

	| descriptors extent mineShape |
	mineShape := self shapeOf: anObject level: level.

	self visitingShape: mineShape of: anObject.

	extent := metaExtent.

	descriptors := self
		               slotsOf: anObject
		               withIndexCollect: [ :descriptor :var :index :collector | 
			               | valueLabel varLabel valueBox value |
			               value := descriptor
				                        addQuotedShapeInDictionary: quotedShapes;
				                        value.

			               valueLabel := self
				                             valueLabelShapeOf: value
				                             describedBy: descriptor
				                             level: level
				                             ifStopped: [ 
				                             descriptor shapeWithPrototypeLabel:
					                             prototypeLabel ]
				                             ifVisited: [ :shape | 
				                             self
					                             shapeHasBeenVisited: shape
					                             childOfShape: mineShape ]
				                             ifNotVisited: [ 
					                             self
						                             valueHasntBeenVisited: value
						                             ithChild: index
						                             ofShape: mineShape
						                             level: level ].

			               valueLabel ifNotNil: [ 
				               extent := extent max: valueLabel extent ].

			               varLabel := self
				                           varLabelShapeOf: anObject
				                           label: var.

			               valueBox := self boxShapeOf: value.


			               collector
				               value: valueLabel
				               value: varLabel
				               value: valueBox ].

	self
		dfsClockTick;
		dfsRecordTimingsOfShape: mineShape;
		createStronglyConnectedComponentIfNecessaryOnShape: mineShape.

	^ self
		  object: anObject
		  descriptors: descriptors
		  extent: self radiusOrPadding + extent x @ extent y
		  shape: mineShape
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTObjectRefsVisit >> initialize [

	| nilLabel |
	super initialize.

	dfsClock := 0.
	maxLevel := 0.
	sccShapeStack := nil.
	sccs := OrderedCollection new.
	levels := Dictionary new.
	quotedShapes := IdentityDictionary new.

	nilLabel := RSLabel new
		            model: nil;
		            yourself.

	prototypeLabel := RSLabel new
		                  fontName: 'Source Code Pro';
		                  yourself.

	metaExtent := nilLabel extent.
	metaColor := nilLabel color lighter lighter lighter.
	metaFontSize := nilLabel fontSize * (Float goldenRatio - 1)
]

{ #category : #accessing }
CTObjectRefsVisit >> levels: aDictionary [

	levels := aDictionary
]

{ #category : #accessing }
CTObjectRefsVisit >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #visiting }
CTObjectRefsVisit >> object: anObject descriptors: descriptors extent: extent shape: mineShape [

	| shapes boxedCompositeShape compositeShape contentLocation classLabel |
	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel value valueShape |
		          "Unpacking."
		          value := slotDescriptor at: #value.
		          varLabel := slotDescriptor at: #varLabel.
		          valueLabel := slotDescriptor at: #valueLabel.
		          valueBox := slotDescriptor at: #valueBox.

		          valueBox extent: extent.

		          valueShape := valueLabel
			                        ifNil: [ 
				                        fromShapes at: valueBox put: mineShape.
				                        valueBox ]
			                        ifNotNil: [ 
				                        RSLocation new
					                        inner;
					                        stick: valueLabel on: valueBox.
				                        RSComposite new
					                        shapes:
						                        (Array with: valueBox with: valueLabel);
					                        yourself ].

		          RSLocation new
			          left;
			          outer;
			          offset: self radiusOrPadding negated @ 0;
			          stick: varLabel on: valueShape.

		          RSComposite new
			          shapes: (Array with: varLabel with: valueShape);
			          yourself ].

	RSVerticalLineLayout new
		verticalGap: 0;
		on: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	contentLocation := shapes
		                   ifEmpty: [ 
			                   | shape x |
			                   shape := quotedShapes
				                            at: anObject
				                            ifPresent: [ :aQuotedShape | 
					                            classLabel := self 
						                                          classLabelShapeOf:
						                                          aQuotedShape model.
					                            aQuotedShape ]
				                            ifAbsent: [ 
					                            classLabel := self 
						                                          classLabelShapeOf:
						                                          anObject.

					                            anObject asString 
						                            asMultilineLabelShape:
						                            prototypeLabel ].

			                   x := shape extent x max: classLabel extent x.
			                   shape extent: x @ shape extent y.

			                   shapes := Array with: shape.

			                   RSLocation new
				                   inner;
				                   left;
				                   yourself ]
		                   ifNotEmpty: [ 
			                   classLabel := self classLabelShapeOf: anObject.

			                   RSLocation new
				                   inner;
				                   right;
				                   yourself ].

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: self radiusOrPadding;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent:
			                       (compositeShape extent x max:
					                        classLabel extent x)
			                       @ compositeShape extent y;
		                       cornerRadius: self radiusOrPadding;
		                       withBorder;
		                       yourself.

	mineShape propertyDfsBoxedSlotsShape: boxedCompositeShape.

	contentLocation stick: compositeShape on: boxedCompositeShape.

	boxedCompositeShape := RSComposite new
		                       shapes: { 
				                       boxedCompositeShape.
				                       compositeShape };
		                       yourself.

	RSLocation new
		above;
		stick: classLabel on: boxedCompositeShape.

	RSAlignment new
		shapes: { 
				classLabel.
				boxedCompositeShape };
		left.

	^ mineShape
		  shapes: { 
				  classLabel.
				  boxedCompositeShape };
		  padding: self radiusOrPadding;
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #accessing }
CTObjectRefsVisit >> rootObject: anObject [

	rootObject := anObject
]

{ #category : #visiting }
CTObjectRefsVisit >> shapeHasBeenVisited: shape childOfShape: mineShape [

	| shapeEntryTime anObject value |
	anObject := mineShape model.
	value := shape model.

	shapeEntryTime := shape propertyDfsEntryTime.
	shapeEntryTime < mineShape propertyDfsEntryTime ifTrue: [ 
		shape propertyDfsIsOnObjectStack ifTrue: [ 
			mineShape propertyDfsLowlinkUpdate: [ :lowlink | 
				lowlink min: shapeEntryTime ] ].

		self assert: anObject ~~ value ]
]

{ #category : #visiting }
CTObjectRefsVisit >> shapeOf: anObject level: level [

	^ RSComposite new
		  model: anObject;
		  propertyDfsDepth: level;
		  propertyDfsTimings: dfsClock @ -1;
		  propertyDfsLowlink: dfsClock;
		  yourself: [ :mineShape | 
			  self
				  addDraggableInteractionOnShape: mineShape;
				  "addPopupInteractionOnShape: mineShape;"
				  addHighlightInteractionOnShape: mineShape ]
]

{ #category : #accessing }
CTObjectRefsVisit >> slotsBlock: aBlock [

	slotsBlock := aBlock
]

{ #category : #visiting }
CTObjectRefsVisit >> slotsOf: anObject withIndexCollect: aBlock [

	^ (slotsBlock value: anObject) withIndexCollect: [ :aDescription :index | 
		  | var value descriptor |
		  descriptor := aDescription isSymbol
			                ifTrue: [ 
			                aDescription asSlotDescriptor selectorHasBeenGiven ]
			                ifFalse: [ 
				                aDescription isAssociation
					                ifTrue: [ 
						                aDescription key asSlotDescriptor
							                blockClosure: aDescription value;
							                yourself ]
					                ifFalse: [ aDescription ] ].

		  var := descriptor selector.
		  value := descriptor value: anObject.

		  aBlock
			  value: descriptor
			  value: var
			  value: index
			  value: [ :valueLabel :varLabel :valueBox | 
				  Dictionary new
					  at: #var put: var;
					  at: #value put: value;
					  at: #valueLabel put: valueLabel;
					  at: #varLabel put: varLabel;
					  at: #valueBox put: valueBox;
					  yourself ] ]
]

{ #category : #accessing }
CTObjectRefsVisit >> stronglyConnectedComponents: aCollection [

	sccs := aCollection
]

{ #category : #accessing }
CTObjectRefsVisit >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #evaluating }
CTObjectRefsVisit >> value [

	| aShape |
	aShape := self
		          forObject: rootObject
		          ithChild: 0
		          of: nil
		          level: 1.

	^ self
		  assert: sccShapeStack isNil;
		  itself: aShape
]

{ #category : #visiting }
CTObjectRefsVisit >> valueHasntBeenVisited: value ithChild: index ofShape: mineShape level: level [

	| childShape |
	self dfsClockTick.

	childShape := self
		              forObject: value
		              ithChild: index
		              of: mineShape model
		              level: level + 1.

	mineShape propertyDfsLowlinkUpdate: [ :lowlink | 
		lowlink min: childShape propertyDfsLowlink ]
]

{ #category : #visiting }
CTObjectRefsVisit >> valueLabelShapeOf: anObject describedBy: descriptor level: level ifStopped: sBlock ifVisited: vBlock ifNotVisited: nvBlock [

	| inline |
	inline := descriptor inlineIfNil: [ 
		          level = maxLevel | anObject isImmediateObject
		          | anObject isNil | anObject isBoolean | anObject isSymbol ].
	^ inline
		  ifTrue: sBlock
		  ifFalse: [ 
			  toShapes at: anObject ifPresent: vBlock ifAbsent: nvBlock.
			  nil ]
]

{ #category : #visiting }
CTObjectRefsVisit >> varLabelShapeOf: anObject label: var [

	^ RSLabel new
		  text: var asString;
		  color: metaColor;
		  when: RSMouseClick do: [ :ev | 
			  (anObject class lookupSelector: var) ifNotNil: [ :cm | cm browse ] ];
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> visitingShape: mineShape of: anObject [

	| level |
	level := levels
		         at: mineShape propertyDfsDepth
		         ifAbsentPut: [ OrderedCollection new ].
	level add: mineShape.

	toShapes at: anObject put: mineShape.

	sccShapeStack := ValueLink new
		                 value: mineShape;
		                 nextLink: sccShapeStack;
		                 yourself.

	^ mineShape propertyDfsObjectStack: sccShapeStack
]
