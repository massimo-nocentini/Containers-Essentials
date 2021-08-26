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
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #dispatched }
CTObjectRefsVisit >> addQuotedShape: shape model: value [

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

	^ aShape propertyDfsEntryTime = aShape propertyDfsLowlink
		  ifTrue: [ 
			  | scc |
			  scc := sccs add: OrderedCollection new.

			  [ 
			  sccShapeStack isNotNil and: [ 
				  sccShapeStack value propertyDfsEntryTime
				  >= aShape propertyDfsEntryTime ] ] whileTrue: [ 
				  | shape |
				  shape := sccShapeStack value
					           propertyDfsSCC: scc;
					           propertyDfsObjectStack: nil;
					           yourself.

				  scc add: shape.

				  sccShapeStack := sccShapeStack nextLink ].

			  self
				  assert: aShape propertyDfsSCC == scc;
				  itself: scc ]
		  ifFalse: [ Array new ]
]

{ #category : #DFS }
CTObjectRefsVisit >> dfsClockTick [

	^ dfsClock := dfsClock + 1
]

{ #category : #DFS }
CTObjectRefsVisit >> dfsRecordTimingsOfShape: mineShape [

	^ mineShape
		  propertyDfsTimings: mineShape propertyDfsEntryTime @ dfsClock;
		  yourself
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
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
		shapeBuilder: CTObjectRefsShapeBuilder new
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

	"https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm"

	| descriptors aShape metaExtent widthsExtent slotRows classShape noSlotsShape |
	aShape := shapeBuilder outline: anObject.

	self
		visitingShape: aShape of: anObject;
		atLevel: level putShape: aShape.

	aDescriptor
		addDraggableInteractionOnShape: aShape;
		"addPopupInteractionOnShape: wholeShape;"
		addHighlightInteractionOnShape: aShape.

	metaExtent := shapeBuilder metaExtent.
	widthsExtent := 0 -> metaExtent x.

	descriptors := slotDescriptorsContext visit: anObject.

	slotRows := descriptors withIndexCollect: [ :childDescriptor :index | 
		            | valueLabel varLabel valueBox value extent |
		            value := childDescriptor
			                     on: anObject;
			                     addQuotedShapeInVisit: self;
			                     value.

		            valueLabel := self
			                          valueLabelShapeOf: value
			                          describedBy: childDescriptor
			                          level: level
			                          ifStopped: [ 
			                          childDescriptor shape: shapeBuilder ]
			                          ifVisited: [ :anAlreadySeenShape | 
				                          self
					                          shapeHasBeenVisited: anAlreadySeenShape
					                          childOfShape: aShape ]
			                          ifNotVisited: [ 
				                          self dfsClockTick.

				                          "The DFS clock advanced, now recur."
				                          self
					                          valueHasntBeenVisited: value
					                          describedBy: childDescriptor
					                          ithChild: index
					                          parent: anObject
					                          shape: aShape
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

				                      fromShapes at: valueBox put: aShape.

				                      widthsExtent value @ metaExtent y ]
			                      ifNotNil: [ 
				                      valueLabel := shapeBuilder pad: valueLabel.
				                      valueLabel extent x
				                      @ (valueLabel extent y max: metaExtent y) ].

		            widthsExtent := (widthsExtent key max: varLabel extent x)
		                            -> (widthsExtent value max: extent x).

		            valueBox height: (extent y max: varLabel extent y).

		            RSSlotRow var: varLabel box: valueBox label: valueLabel ].

	self
		dfsClockTick;
		dfsRecordTimingsOfShape: aShape;
		createStronglyConnectedComponentIfNecessaryOnShape: aShape.

	noSlotsShape := slotRows
		                ifEmpty: [ 
			                quotedShapes
				                at: anObject
				                ifAbsent: [ shapeBuilder multilineLabel: anObject ] ]
		                ifNotEmpty: [ 
			                RSComposite new
				                model: anObject;
				                yourself ].

	classShape := aDescriptor
		              header: noSlotsShape model
		              shapeBuilder: shapeBuilder.

	^ shapeBuilder
		  classShape: classShape
		  noSlotsShape: noSlotsShape
		  descriptors: slotRows
		  extent: widthsExtent
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
CTObjectRefsVisit >> valueHasntBeenVisited: anObject describedBy: aDescriptor ithChild: index parent: aParent shape: mineShape level: level [

	| childShape |
	childShape := self
		              object: anObject
		              slotsDescriptor: aDescriptor
		              childNo: index
		              parent: aParent
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
