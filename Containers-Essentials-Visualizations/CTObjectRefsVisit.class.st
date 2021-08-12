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
		'levels',
		'quotedShapes',
		'slotDescriptorsContext',
		'oneToManyShapes'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTObjectRefsVisit >> addQuotedShape: shape model: value [

	shape height: shape height + self radiusOrPaddingDouble.

	^ quotedShapes at: value put: shape
]

{ #category : #visiting }
CTObjectRefsVisit >> atLevel: aNumber putShape: aShape [

	aShape propertyDfsDepth: aNumber.

	^ (levels at: aNumber ifAbsentPut: [ OrderedCollection new ])
		  add: aShape;
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
	oneToManyShapes := IdentityDictionary new
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
CTObjectRefsVisit >> object: anObject describedBy: aDescriptor descriptors: descriptors extent: width shape: mineShape [

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

	classLabel := aDescriptor header value: anObject.

	contentLocation := shapes
		                   ifEmpty: [ 
			                   | shape x |
			                   shape := quotedShapes
				                            at: anObject
				                            ifPresent: [ :aQuotedShape | 
					                            classLabel := aDescriptor header 
						                                          value:
						                                          aQuotedShape model.
					                            aQuotedShape ]
				                            ifAbsent: [ 
				                            aDescriptor multilineLabelShapeOf:
					                            anObject ].

			                   x := shape extent x max: classLabel extent x.
			                   shape extent: x @ shape extent y.

			                   shapes := Array with: shape.

			                   RSLocation new
				                   inner;
				                   left;
				                   yourself ]
		                   ifNotEmpty: [ 
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
CTObjectRefsVisit >> object: anObject slotsDescriptor: aDescriptor childNo: i parent: aParent level: level [

	| descriptors maxX aShape metaExtent |
	aShape := self shapeOf: anObject.

	self
		visitingShape: aShape of: anObject;
		atLevel: level putShape: aShape.

	aDescriptor
		addDraggableInteractionOnShape: aShape;
		"addPopupInteractionOnShape: wholeShape;"
		addHighlightInteractionOnShape: aShape.

	metaExtent := aDescriptor metaExtent.
	maxX := metaExtent x.

	descriptors := self
		               slotsDescriptors: anObject
		               withIndexDo: [ :childDescriptor :index | 
			               | valueLabel varLabel valueBox value |
			               value := childDescriptor
				                        addQuotedShapeInVisit: self;
				                        value.

			               valueLabel := self
				                             valueLabelShapeOf: value
				                             describedBy: childDescriptor
				                             level: level
				                             ifStopped: [ childDescriptor shape ]
				                             ifVisited: [ :shape | 
				                             self
					                             shapeHasBeenVisited: shape
					                             childOfShape: aShape ]
				                             ifNotVisited: [ 
					                             self
						                             valueHasntBeenVisited: value
						                             describedBy: childDescriptor
						                             ithChild: index
						                             ofShape: aShape
						                             level: level ].

			               varLabel := childDescriptor varLabelShapeOf:
				                           anObject.

			               valueBox := (childDescriptor boxShapeOf: value) 
				                           yourself: [ :aBox | 
					                           | height |
					                           height := valueLabel
						                                     ifNil: [ metaExtent y ]
						                                     ifNotNil: [ 
							                                     | extent |
							                                     extent := valueLabel
								                                               extent.
							                                     maxX := maxX max: extent x.
							                                     extent y ].
					                           height := height max:
						                                     varLabel extent y.
					                           aBox height: height ].

			               valueLabel ifNil: [ 
				               valueBox addInteraction: RSHighlightable withLines.

				               childDescriptor isOneToManyFromVisit: self ].


			               childDescriptor
				               valueLabel: valueLabel;
				               varLabel: varLabel;
				               valueBox: valueBox;
				               yourself ].

	self
		dfsClockTick;
		dfsRecordTimingsOfShape: aShape;
		createStronglyConnectedComponentIfNecessaryOnShape: aShape.

	^ self
		  object: anObject
		  describedBy: aDescriptor
		  descriptors: descriptors
		  extent: maxX + self radiusOrPaddingDouble
		  shape: aShape
]

{ #category : #'as yet unclassified' }
CTObjectRefsVisit >> oneToMany: aValue [

	| manyShapes |
	manyShapes := aValue collect: [ :each | toShapes at: each ].

	oneToManyShapes at: aValue put: manyShapes
]

{ #category : #accessing }
CTObjectRefsVisit >> oneToManyShapes: aDictionary [

	oneToManyShapes := aDictionary
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPaddingDouble [

	^ self radiusOrPadding double
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
CTObjectRefsVisit >> shapeOf: anObject [

	^ RSComposite new
		  model: anObject;
		  yourself
]

{ #category : #accessing }
CTObjectRefsVisit >> slotDescriptorsContext: aBlock [

	slotDescriptorsContext := aBlock
]

{ #category : #visiting }
CTObjectRefsVisit >> slotsDescriptors: anObject withIndexDo: aBlock [

	^ (slotDescriptorsContext visit: anObject)
		  withIndexDo: [ :aDescriptor :index | 
			  aDescriptor on: anObject.
			  aBlock value: aDescriptor value: index ];
		  yourself
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
		          object: rootObject
		          slotsDescriptor: slotDescriptorsContext rootDescriptor
		          childNo: 0
		          parent: nil
		          level: 1.

	^ self
		  assert: sccShapeStack isNil;
		  itself: aShape
]

{ #category : #visiting }
CTObjectRefsVisit >> valueHasntBeenVisited: anObject describedBy: aDescriptor ithChild: index ofShape: mineShape level: level [

	| childShape |
	self dfsClockTick.

	childShape := self
		              object: anObject
		              slotsDescriptor: aDescriptor
		              childNo: index
		              parent: mineShape model
		              level: level + 1.

	mineShape propertyDfsLowlinkUpdate: [ :lowlink | 
		lowlink min: childShape propertyDfsLowlink ].

	^ childShape
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
CTObjectRefsVisit >> visitingShape: aShape of: anObject [

	toShapes at: anObject put: aShape.

	sccShapeStack := ValueLink new
		                 value: aShape;
		                 nextLink: sccShapeStack;
		                 yourself.

	^ aShape
		  propertyDfsObjectStack: sccShapeStack;
		  propertyDfsTimings: dfsClock @ -1;
		  propertyDfsLowlink: dfsClock;
		  yourself
]
