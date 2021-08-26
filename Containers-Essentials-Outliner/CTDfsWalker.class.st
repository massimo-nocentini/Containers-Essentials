"
I walk a graph of objects according to the Depth-First Search strategy;
additionally, I also take care of Strongly Connected Components (also see 
Tarjan, R. E. (1972), ""Depth-first search and linear graph algorithms"", 
SIAM Journal on Computing, 1 (2): 146–160).
"
Class {
	#name : #CTDfsWalker,
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
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #dispatched }
CTDfsWalker >> addQuotedShape: shape model: value [

	^ quotedShapes at: value put: shape
]

{ #category : #accessing }
CTDfsWalker >> atLevel: aNumber putShape: aShape [

	aShape propertyDfsDepth: aNumber.

	^ (levels at: aNumber ifAbsentPut: [ OrderedCollection new ])
		  add: aShape;
		  yourself
]

{ #category : #DFS }
CTDfsWalker >> createStronglyConnectedComponentIfNecessaryOnShape: aShape [

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
CTDfsWalker >> dfsClockTick [

	^ dfsClock := dfsClock + 1
]

{ #category : #DFS }
CTDfsWalker >> dfsRecordTimingsOfShape: mineShape [

	^ mineShape
		  propertyDfsTimings: mineShape propertyDfsEntryTime @ dfsClock;
		  yourself
]

{ #category : #accessing }
CTDfsWalker >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTDfsWalker >> initialize [

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
		shapeBuilder: CTDfsShapeBuilder new
]

{ #category : #accessing }
CTDfsWalker >> levels: aDictionary [

	levels := aDictionary
]

{ #category : #accessing }
CTDfsWalker >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #DFS }
CTDfsWalker >> object: anObject slotsDescriptor: aDescriptor childNo: i parent: aParent level: level [

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
CTDfsWalker >> oneToMany: aValue [

	| manyShapes |
	manyShapes := aValue collect: [ :each | toShapes at: each ].

	oneToManyShapes at: aValue put: manyShapes
]

{ #category : #accessing }
CTDfsWalker >> oneToManyShapes: aDictionary [

	oneToManyShapes := aDictionary
]

{ #category : #accessing }
CTDfsWalker >> quotedShapesAt: anObject ifPresent: pBlock ifAbsent: aBlock [

	^ quotedShapes at: anObject ifPresent: pBlock ifAbsent: aBlock
]

{ #category : #accessing }
CTDfsWalker >> rootObject: anObject [

	rootObject := anObject
]

{ #category : #accessing }
CTDfsWalker >> shapeBuilder: aShapeBuilder [

	shapeBuilder := aShapeBuilder
]

{ #category : #DFS }
CTDfsWalker >> shapeHasBeenVisited: childShape childOfShape: parentShape [

	| shapeEntryTime |
	shapeEntryTime := childShape propertyDfsEntryTime.

	(childShape propertyDfsIsOnObjectStack and: [ 
		 shapeEntryTime < parentShape propertyDfsEntryTime ]) ifTrue: [ 
		parentShape propertyDfsLowlinkUpdate: [ :lowlink | 
			lowlink min: shapeEntryTime ].

		self assert: parentShape model ~~ childShape model ]
]

{ #category : #accessing }
CTDfsWalker >> slotDescriptorsContext: aBlock [

	slotDescriptorsContext := aBlock
]

{ #category : #accessing }
CTDfsWalker >> stronglyConnectedComponents: aCollection [

	sccs := aCollection
]

{ #category : #accessing }
CTDfsWalker >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #DFS }
CTDfsWalker >> value [

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
CTDfsWalker >> valueHasntBeenVisited: anObject describedBy: aDescriptor ithChild: index parent: aParent shape: mineShape level: level [

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
CTDfsWalker >> valueLabelShapeOf: anObject describedBy: descriptor level: level ifStopped: sBlock ifVisited: vBlock ifNotVisited: nvBlock [

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
CTDfsWalker >> visitingShape: aShape of: anObject [

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
