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
		'oneToManyShapes',
		'shapeBuilder'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #dispatched }
CTObjectRefsVisit >> addQuotedShape: shape model: value [

	shape height: shape height + shapeBuilder radiusOrPaddingDouble.

	^ quotedShapes at: value put: shape
]

{ #category : #accessing }
CTObjectRefsVisit >> atLevel: aNumber putShape: aShape [

	aShape propertyDfsDepth: aNumber.

	^ (levels at: aNumber ifAbsentPut: [ OrderedCollection new ])
		  add: aShape;
		  yourself
]

{ #category : #DFS }
CTObjectRefsVisit >> createStronglyConnectedComponentIfNecessaryOnShape: aShape [

	self
		assert: aShape propertyDfsEntryTime isNotNil;
		assert: aShape propertyDfsLowlink isNotNil.

	^ aShape propertyDfsEntryTime = aShape propertyDfsLowlink ifTrue: [ 
		  | scc |
		  scc := sccs add: OrderedCollection new.

		  [ 
		  sccShapeStack isNotNil and: [ 
			  sccShapeStack value propertyDfsEntryTime
			  >= aShape propertyDfsEntryTime ] ] whileTrue: [ 
			  | shape |
			  shape := sccShapeStack value.
			  scc add: shape.
			  sccShapeStack := sccShapeStack nextLink.
			  shape
				  propertyDfsSCC: scc;
				  propertyDfsObjectStack: nil ].

		  self
			  assert: aShape propertyDfsSCC == scc;
			  itself: scc ]
]

{ #category : #DFS }
CTObjectRefsVisit >> dfsClockTick [

	^ dfsClock := dfsClock + 1
]

{ #category : #DFS }
CTObjectRefsVisit >> dfsRecordTimingsOfShape: mineShape [

	mineShape propertyDfsTimings:
		mineShape propertyDfsEntryTime @ dfsClock.

	^ mineShape
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapesAt: aBoxShape put: aShape [

	^ fromShapes at: aBoxShape put: aShape
]

{ #category : #initialization }
CTObjectRefsVisit >> initialize [

	super initialize.

	"Both the dfs clock and the shapes stack is managed locally, so
	 no client of me can interact with these data."
	dfsClock := 0.
	sccShapeStack := nil.

	"The handling of quoted shapes is my own responsibility only."
	quotedShapes := IdentityDictionary new.

	self
		maxLevel: 0;
		stronglyConnectedComponents: OrderedCollection new;
		levels: Dictionary new;
		oneToManyShapes: IdentityDictionary new;
		shapeBuilder: (CTObjectRefsShapeBuilder new
				 senderVisit: self;
				 yourself)
]

{ #category : #accessing }
CTObjectRefsVisit >> levels: aDictionary [

	levels := aDictionary
]

{ #category : #accessing }
CTObjectRefsVisit >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #DFS }
CTObjectRefsVisit >> object: anObject slotsDescriptor: aDescriptor childNo: i parent: aParent level: level [

	| descriptors maxX aShape metaExtent |
	aShape := shapeBuilder outline: anObject.

	self
		visitingShape: aShape of: anObject;
		atLevel: level putShape: aShape.

	aDescriptor
		addDraggableInteractionOnShape: aShape;
		"addPopupInteractionOnShape: wholeShape;"
		addHighlightInteractionOnShape: aShape.

	metaExtent := shapeBuilder metaExtent.
	maxX := metaExtent x.

	descriptors := self
		               slotsDescriptors: anObject
		               withIndexDo: [ :childDescriptor :index | 
			               | valueLabel varLabel valueBox value extent |
			               value := childDescriptor
				                        addQuotedShapeInVisit: self;
				                        value.

			               valueLabel := self
				                             valueLabelShapeOf: value
				                             describedBy: childDescriptor
				                             level: level
				                             ifStopped: [ 
				                             childDescriptor shape: shapeBuilder ]
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

			               varLabel := childDescriptor
				                           varLabelShapeOf: anObject
				                           shapeBuilder: shapeBuilder.

			               valueBox := shapeBuilder box: value.

			               extent := valueLabel
				                         ifNil: [ 
					                         childDescriptor 
						                         addHighlightWithLinesInteractionOnShape:
						                         valueBox.
					                         maxX @ metaExtent y ]
				                         ifNotNil: [ valueLabel extent ].

			               maxX := maxX max: extent x.
			               valueBox height: (extent y max: varLabel extent y).

			               childDescriptor
				               valueLabel: valueLabel;
				               varLabel: varLabel;
				               valueBox: valueBox;
				               yourself ].

	self
		dfsClockTick;
		dfsRecordTimingsOfShape: aShape;
		createStronglyConnectedComponentIfNecessaryOnShape: aShape.

	^ shapeBuilder
		  object: anObject
		  describedBy: aDescriptor
		  descriptors: descriptors
		  extent: maxX + shapeBuilder radiusOrPaddingDouble
		  shape: aShape
]

{ #category : #dispatched }
CTObjectRefsVisit >> oneToMany: aValue [

	| manyShapes |
	manyShapes := aValue collect: [ :each | toShapes at: each ].

	oneToManyShapes at: aValue put: manyShapes
]

{ #category : #accessing }
CTObjectRefsVisit >> oneToManyShapes: aDictionary [

	oneToManyShapes := aDictionary
]

{ #category : #accessing }
CTObjectRefsVisit >> quotedShapesAt: anObject ifPresent: pBlock ifAbsent: aBlock [

	^ quotedShapes at: anObject ifPresent: pBlock ifAbsent: aBlock
]

{ #category : #accessing }
CTObjectRefsVisit >> rootObject: anObject [

	rootObject := anObject
]

{ #category : #accessing }
CTObjectRefsVisit >> shapeBuilder: aShapeBuilder [

	shapeBuilder := aShapeBuilder
]

{ #category : #DFS }
CTObjectRefsVisit >> shapeHasBeenVisited: childShape childOfShape: parentShape [

	| shapeEntryTime |
	shapeEntryTime := childShape propertyDfsEntryTime.

	(childShape propertyDfsIsOnObjectStack and: [ 
		 shapeEntryTime < parentShape propertyDfsEntryTime ]) ifTrue: [ 
		parentShape propertyDfsLowlinkUpdate: [ :lowlink | 
			lowlink min: shapeEntryTime ].

		self assert: parentShape model ~~ childShape model ]
]

{ #category : #accessing }
CTObjectRefsVisit >> slotDescriptorsContext: aBlock [

	slotDescriptorsContext := aBlock
]

{ #category : #accessing }
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

{ #category : #DFS }
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

{ #category : #DFS }
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

{ #category : #DFS }
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
			  descriptor isOneToManyFromVisit: self.
			  nil ]
]

{ #category : #DFS }
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
