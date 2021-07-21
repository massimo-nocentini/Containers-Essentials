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
		'quotedShapes',
		'initialDescriptor'
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

{ #category : #adding }
CTObjectRefsVisit >> addQuotedShape: shape model: value [

	shape height: shape height + self radiusOrPaddingDouble.

	^ quotedShapes at: value put: shape
]

{ #category : #visiting }
CTObjectRefsVisit >> boxShapeOf: value [

	^ RSBox new
		  model: value;
		  color: Color white;
		  cornerRadius: self radiusOrPadding;
		  withBorder;
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> classLabelShapeOf: anObject [

	^ anObject class asShapeAllSuperclassesIndented: [ :each | 
		  RSLabel new
			  text: each name;
			  fontSize: metaFontSize;
			  color: metaColor;
			  when: RSMouseLeftClick do: [ :ev | each browse ];
			  yourself: [ :labelShape | 
				  each hasAbstractMethods ifTrue: [ labelShape italic ] ] ]
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

	| descriptors maxX mineShape |
	mineShape := self shapeOf: anObject level: level.

	self visitingShape: mineShape of: anObject.

	maxX := metaExtent x.

	descriptors := self
		               slotsOf: anObject
		               withIndexCollect: [ :descriptor :index | 
			               | valueLabel varLabel valueBox value |
			               value := descriptor
				                        addQuotedShapeInVisit: self;
				                        value.

			               valueLabel := self
				                             valueLabelShapeOf: value
				                             describedBy: descriptor
				                             level: level
				                             ifStopped: [ 
				                             descriptor shapeWithPrototypeLabel:
					                             prototypeLabel copy ]
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

			               varLabel := self
				                           varLabelShapeOf: anObject
				                           label: descriptor selector.

			               valueBox := (self boxShapeOf: value) yourself: [ 
				                           :aBox | 
				                           | height |
				                           height := valueLabel
					                                     ifNil: [ metaExtent y ]
					                                     ifNotNil: [ 
						                                     | extent |
						                                     extent := valueLabel extent.
						                                     maxX := maxX max: extent x.
						                                     extent y ].
				                           height := height max: varLabel extent y.
				                           aBox height: height.

				                           valueLabel ifNil: [ 
					                           aBox addInteraction:
						                           RSHighlightable withLines ] ].

			               descriptor
				               valueLabel: valueLabel;
				               varLabel: varLabel;
				               valueBox: valueBox;
				               yourself ].

	self
		dfsClockTick;
		dfsRecordTimingsOfShape: mineShape;
		createStronglyConnectedComponentIfNecessaryOnShape: mineShape.

	^ self
		  object: anObject
		  descriptors: descriptors
		  extent: maxX + self radiusOrPaddingDouble
		  shape: mineShape
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTObjectRefsVisit >> initialize [

	super initialize.

	dfsClock := 0.
	maxLevel := 0.
	sccShapeStack := nil.

	sccs := OrderedCollection new.
	levels := Dictionary new.
	quotedShapes := IdentityDictionary new.

	prototypeLabel := RSLabel new
		                  model: nil;
		                  fontName: 'Source Code Pro';
		                  yourself.

	prototypeLabel withText: '...' do: [ 
		metaExtent := prototypeLabel extent.
		metaColor := prototypeLabel color lighter lighter lighter.
		metaFontSize := prototypeLabel fontSize * (Float goldenRatio - 1) ]
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
CTObjectRefsVisit >> object: anObject descriptors: descriptors extent: width shape: mineShape [

	| shapes boxedCompositeShape compositeShape contentLocation classLabel padding |
	padding := self radiusOrPadding.

	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel valueShape |
		          "Unpacking."
		          varLabel := slotDescriptor varLabel.
		          valueLabel := slotDescriptor valueLabel.
		          valueBox := slotDescriptor valueBox.

		          valueBox width: width.

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
			          offset: padding negated @ 0;
			          stick: varLabel on: valueShape.

		          RSComposite new
			          shapes: (Array with: varLabel with: valueShape);
			          yourself ].

	RSVerticalLineLayout new
		verticalGap: padding;
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
						                            prototypeLabel copy ].

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
		                  padding: padding;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent:
			                       (compositeShape extent x max:
					                        classLabel extent x)
			                       @ compositeShape extent y;
		                       cornerRadius: padding;
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
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPaddingDouble [

	^ Float goldenRatio double double
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

	(shape propertyDfsIsOnObjectStack and: [ 
		 shapeEntryTime < mineShape propertyDfsEntryTime ]) ifTrue: [ 
		mineShape propertyDfsLowlinkUpdate: [ :lowlink | 
			lowlink min: shapeEntryTime ].

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

		  aBlock value: descriptor value: index ]
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

	| shouldInline |
	shouldInline := descriptor
		                inline: anObject
		                level: level
		                default:
			                level = maxLevel | anObject isImmediateObject
			                | anObject isNil | anObject isBoolean
			                | anObject isSymbol.

	^ shouldInline
		  ifTrue: sBlock
		  ifFalse: [ 
			  toShapes at: anObject ifPresent: vBlock ifAbsent: nvBlock.
			  nil ]
]

{ #category : #visiting }
CTObjectRefsVisit >> varLabelShapeOf: anObject label: var [

	| composite aBlock |
	composite := var asString asMultilineLabelShape: (RSLabel new
			              color: metaColor;
			              yourself).

	RSAlignment new
		shapes: composite shapes;
		right.

	aBlock := (anObject class lookupSelector: var)
		          ifNil: [ [ :ev |  ] ]
		          ifNotNil: [ :cm | 
			          cm firstComment ifNotEmpty: [ :firstComment | 
				          | popup |
				          popup := RSPopup new
					                   shapeBuilder: [ :aComment | 
						                   | commentComposite box |
						                   commentComposite := aComment 
							                                       asMultilineLabelShape:
								                                       prototypeLabel.

						                   box := RSBox new
							                          withBorder;
							                          color: Color veryVeryLightGray;
							                          cornerRadius: Float goldenRatio * 2;
							                          extent:
								                          commentComposite extent
								                          + (Float goldenRatio * 4).

						                   RSLocation new center
							                   stick: commentComposite
							                   on: box.

						                   RSComposite new
							                   shapes: { 
									                   box.
									                   commentComposite };
							                   yourself ];
					                   model: firstComment;
					                   yourself.

				          composite addInteraction: popup ].
			          [ :ev | cm browse ] ].
	^ composite
		  when: RSMouseLeftClick do: aBlock;
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
