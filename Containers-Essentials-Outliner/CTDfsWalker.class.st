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
		'levels',
		'quotedShapes',
		'slotDescriptorsContext',
		'oneToManyShapes',
		'shapeBuilder',
		'startTimestamp',
		'maxDurationInMicroseconds',
		'skipBacks',
		'skipNils',
		'skipEmptyCollections'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #DFS }
CTDfsWalker >> addInteractionsBySlotDescriptor: aDescriptor onShape: aShape [

	aDescriptor addDraggableInteractionOnShape: aShape
	"addPopupInteractionOnShape: wholeShape;"
]

{ #category : #dispatched }
CTDfsWalker >> addQuotedShape: shape model: value [

	quotedShapes at: value put: shape
]

{ #category : #accessing }
CTDfsWalker >> atLevel: aNumber putShape: aShape [

	| level |
	aShape propertyDfsDepth: aNumber.

	level := levels at: aNumber ifAbsentPut: [ OrderedCollection new ].
	level add: aShape
]

{ #category : #DFS }
CTDfsWalker >> collectSlotRowsInto: slotsRows for: anObject shape: aShape at: level widthsAssociation: widthsAssociation metaExtent: metaExtent [

	| descriptors |
	descriptors := (slotDescriptorsContext visit: anObject) select: [ 
		               :each | each enabled ].

	descriptors withIndexDo: [ :childDescriptor :childIndex | 
		| value |
		value := childDescriptor on: anObject walker: self.

		(self shouldSkip: value) ifFalse: [ 
			| slotsRow |
			slotsRow := self
				            value: value
				            descriptor: childDescriptor
				            level: level
				            ithChild: childIndex
				            parent: anObject
				            parentShape: aShape
				            widthsAssociation: widthsAssociation
				            metaExtent: metaExtent.

			slotsRows add: slotsRow ] ].

	^ slotsRows
]

{ #category : #initialization }
CTDfsWalker >> copyForQuoteSlotDescriptor: aSlotDescriptor [

	^ self class new
		  shapeBuilder: shapeBuilder;
		  slotDescriptorsContext: slotDescriptorsContext;
		  yourself
]

{ #category : #accessing }
CTDfsWalker >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #DFS }
CTDfsWalker >> incrementDfsClock [

	^ dfsClock := dfsClock + 1
]

{ #category : #initialization }
CTDfsWalker >> initialize [

	super initialize.

	"Both the dfs clock and the shapes stack is managed locally, so
	 no client of me can interact with these data."
	dfsClock := 0.

	"The handling of quoted shapes is my own responsibility only."
	quotedShapes := IdentityDictionary new.

	self
		maxLevel: 0;
		skipNils: false;
		skipBacks: false;
		skipEmptyCollections: false;
		levels: Dictionary new;
		oneToManyShapes: IdentityDictionary new;
		maxDurationInMicroseconds: 2 seconds asMicroseconds;
		slotDescriptorsContext: CTSlotDescriptorsVisitor new;
		shapeBuilder: CTDfsShapeBuilder new
]

{ #category : #accessing }
CTDfsWalker >> levels: aDictionary [

	levels := aDictionary
]

{ #category : #accessing }
CTDfsWalker >> maxDurationInMicroseconds: microSeconds [

	maxDurationInMicroseconds := microSeconds
]

{ #category : #accessing }
CTDfsWalker >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #DFS }
CTDfsWalker >> object: anObject slotDescriptor: aDescriptor ithChild: parentIndex parent: aParent level: level [

	| aShape metaExtent widthsAssociation slotsRows |
	aShape := shapeBuilder outline: anObject.
	metaExtent := shapeBuilder metaExtent.
	widthsAssociation := 0 -> metaExtent x.

	self
		visiting: anObject shape: aShape;
		atLevel: level putShape: aShape;
		addInteractionsBySlotDescriptor: aDescriptor onShape: aShape.

	slotsRows := self
		             collectSlotRowsInto: OrderedCollection new
		             for: anObject
		             shape: aShape
		             at: level
		             widthsAssociation: widthsAssociation
		             metaExtent: metaExtent.

	self
		incrementDfsClock;
		recordDfsTimingsOfShape: aShape.

	^ self
		  synthesize: anObject
		  descriptor: aDescriptor
		  shape: aShape
		  slotsRows: slotsRows
		  widthsAssociation: widthsAssociation
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

{ #category : #initialization }
CTDfsWalker >> postCopy [

	super postCopy.

	"Both the dfs clock and the shapes stack is managed locally, so
	 no client of me can interact with these data."
	dfsClock := 0.

	"The handling of quoted shapes is my own responsibility only."
	quotedShapes := IdentityDictionary new.

	self
		levels: Dictionary new;
		oneToManyShapes: IdentityDictionary new
]

{ #category : #DFS }
CTDfsWalker >> recordDfsTimingsOfShape: aShape [

	aShape propertyDfsTimings: aShape propertyDfsEntryTime @ dfsClock
]

{ #category : #accessing }
CTDfsWalker >> shapeBuilder [

	^ shapeBuilder
]

{ #category : #accessing }
CTDfsWalker >> shapeBuilder: aShapeBuilder [

	shapeBuilder := aShapeBuilder
]

{ #category : #DFS }
CTDfsWalker >> shapeHasBeenVisited: childShape childOfShape: parentShape [

	
]

{ #category : #DFS }
CTDfsWalker >> shouldSkip: value [

	^ (skipNils and: [ value isNil ]) or: [ 
		  (skipBacks and: [ toShapes includesKey: value ]) or: [ 
			  value isCollection and: [ 
				  skipEmptyCollections and: [ value isEmpty ] ] ] ]
]

{ #category : #accessing }
CTDfsWalker >> skipBacks: aBoolean [

	skipBacks := aBoolean
]

{ #category : #accessing }
CTDfsWalker >> skipEmptyCollections: aBoolean [

	skipEmptyCollections := aBoolean
]

{ #category : #accessing }
CTDfsWalker >> skipNils: aBoolean [

	skipNils := aBoolean
]

{ #category : #accessing }
CTDfsWalker >> slotDescriptorsContext: aBlock [

	slotDescriptorsContext := aBlock
]

{ #category : #DFS }
CTDfsWalker >> synthesize: anObject descriptor: aDescriptor shape: aShape slotsRows: slotsRows widthsAssociation: widthsAssociation [

	| noSlotsShape classShape |
	noSlotsShape := slotsRows
		                ifEmpty: [ 
			                quotedShapes
				                at: anObject
				                ifAbsent: [ shapeBuilder multilineLabel: anObject ] ]
		                ifNotEmpty: [ 
			                RSComposite new
				                model: anObject;
				                shapes: RSGroup new;
				                extent: 0 @ 0;
				                yourself ].

	classShape := aDescriptor
		              header: noSlotsShape model
		              shapeBuilder: shapeBuilder.

	^ shapeBuilder
		  classShape: classShape
		  noSlotsShape: noSlotsShape
		  descriptors: slotsRows
		  widthsAssociation: widthsAssociation
		  shape: aShape
]

{ #category : #accessing }
CTDfsWalker >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #API }
CTDfsWalker >> value: rootObject [

	startTimestamp := Time microsecondClockValue.

	^ self
		  object: rootObject
		  slotDescriptor: slotDescriptorsContext rootDescriptor
		  ithChild: 0
		  parent: nil
		  level: 1
]

{ #category : #DFS }
CTDfsWalker >> value: value descriptor: childDescriptor level: level ithChild: ithChild parent: anObject parentShape: aShape widthsAssociation: widthsExtent metaExtent: metaExtent [

	| valueLabel varLabel valueBox extent |
	valueLabel := self
		              valueLabelShapeOf: value
		              describedBy: childDescriptor
		              level: level
		              ifStopped: [ 
		              childDescriptor shape: value walker: self ]
		              ifVisited: [ :anAlreadySeenShape | 
			              self
				              shapeHasBeenVisited: anAlreadySeenShape
				              childOfShape: aShape ]
		              ifNotVisited: [ 
			              self incrementDfsClock.

			              "The DFS clock advanced, now recur."
			              self
				              valueHasntBeenVisited: value
				              describedBy: childDescriptor
				              ithChild: ithChild
				              parent: anObject
				              shape: aShape
				              level: level ].

	varLabel := childDescriptor
		            varLabelShapeOf: anObject
		            shapeBuilder: shapeBuilder.

	valueBox := shapeBuilder box: value.

	valueLabel
		ifNil: [ 
			childDescriptor addHighlightWithLinesInteractionOnShape: valueBox.

			fromShapes at: valueBox put: aShape.

			valueBox color: valueBox color lighter lighter.

			extent := widthsExtent value @ metaExtent y ]
		ifNotNil: [ 
			| y |
			valueLabel := shapeBuilder pad: valueLabel.

			y := valueLabel extent y max: metaExtent y.

			(quotedShapes includesKey: value) ifTrue: [ 
				valueBox color: Color transparent ].

			extent := valueLabel extent x @ y ].

	widthsExtent
		key: (widthsExtent key max: varLabel extent x);
		value: (widthsExtent value max: extent x).

	valueBox height: (extent y max: varLabel extent y).

	^ RSGroupSlotsRow var: varLabel box: valueBox labelOrNil: valueLabel
]

{ #category : #DFS }
CTDfsWalker >> valueHasntBeenVisited: anObject describedBy: aDescriptor ithChild: ithChild parent: aParent shape: mineShape level: level [

	^ self
		  object: anObject
		  slotDescriptor: aDescriptor
		  ithChild: ithChild
		  parent: aParent
		  level: level + 1
]

{ #category : #DFS }
CTDfsWalker >> valueLabelShapeOf: anObject describedBy: descriptor level: level ifStopped: sBlock ifVisited: vBlock ifNotVisited: nvBlock [

	| shouldInline boolean durationInMicroseconds |
	durationInMicroseconds := Time microsecondsSince: startTimestamp.

	boolean := level = maxLevel
	           | (durationInMicroseconds > maxDurationInMicroseconds)
	           | anObject isImmediateObject | anObject isNil
	           | anObject isSymbol | (anObject == true)
	           | (anObject == false) | (anObject == Float infinity)
	           | (anObject == Float negativeInfinity).

	shouldInline := descriptor
		                inline: anObject
		                level: level
		                default: boolean.

	^ shouldInline
		  ifTrue: sBlock
		  ifFalse: [ 
			  toShapes at: anObject ifPresent: vBlock ifAbsent: nvBlock.
			  descriptor isOneToMany: anObject walker: self.
			  nil ]
]

{ #category : #DFS }
CTDfsWalker >> visiting: anObject shape: aShape [

	toShapes at: anObject put: aShape.

	aShape propertyDfsTimings: dfsClock @ -1
]
