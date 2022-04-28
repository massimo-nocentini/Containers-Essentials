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

{ #category : #shapes }
CTDfsWalker >> addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape [

	aDescriptor addDraggableInteractionOnShape: aShape
	"addPopupInteractionOnShape: wholeShape;"
]

{ #category : #shapes }
CTDfsWalker >> addQuotedShape: shape model: value [

	quotedShapes at: value put: shape
]

{ #category : #shapes }
CTDfsWalker >> atLevel: aNumber putShape: aShape [

	| level |
	aShape propertyDfsDepth: aNumber.

	level := levels at: aNumber ifAbsentPut: [ OrderedCollection new ].
	level add: aShape
]

{ #category : #shapes }
CTDfsWalker >> collectDescriptors: descriptors object: object shape: shape at: level widths_Association: widthsAssociation metaExtent: metaExtent [

	| rows |
	rows := OrderedCollection new.

	descriptors select: [ :each | each enabled ] thenDo: [ :each | 
		| value |
		value := each on: object walker: self.

		(self shouldSkip: value) ifFalse: [ 
			| slotsRow |
			slotsRow := self
				            value: value
				            descriptor: each
				            level: level
				            ithChild: rows size + 1
				            parent: object
				            parentShape: shape
				            widths_Association: widthsAssociation
				            metaExtent: metaExtent.

			rows add: slotsRow ] ].

	^ rows
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
CTDfsWalker >> object: object slotDescriptor: descriptor ithChild: parentIndex parent: parent level: level [

	| shape metaExtent widthsAssociation slotsRows descriptors |
	shape := shapeBuilder outline: object.
	metaExtent := shapeBuilder metaExtent.
	widthsAssociation := 0 -> metaExtent x.

	descriptors := slotDescriptorsContext visit: object.

	self
		visiting: object shape: shape;
		atLevel: level putShape: shape;
		addInteractionsUsingSlotDescriptor: descriptor onShape: shape.

	slotsRows := self
		             collectDescriptors: descriptors
		             object: object
		             shape: shape
		             at: level
		             widths_Association: widthsAssociation
		             metaExtent: metaExtent.

	self
		incrementDfsClock;
		recordDfsTimingsOnShape: shape.

	^ self
		  synthesize: object
		  descriptor: descriptor
		  shape: shape
		  slotsRows: slotsRows
		  widths_Association: widthsAssociation
]

{ #category : #shapes }
CTDfsWalker >> oneToMany: aValue [

	| manyShapes |
	manyShapes := aValue collect: [ :each | toShapes at: each ].

	oneToManyShapes at: aValue put: manyShapes
]

{ #category : #accessing }
CTDfsWalker >> oneToManyShapes: aDictionary [

	oneToManyShapes := aDictionary
]

{ #category : #copying }
CTDfsWalker >> postCopy [

	super postCopy.

	"Both the dfs clock and the shapes stack is managed locally, so
	 no client of me can interact with these data."
	dfsClock := 0.

	"The handling of quoted shapes is my own responsibility only."
	quotedShapes := quotedShapes class new.

	self
		levels: levels class new;
		oneToManyShapes: oneToManyShapes class new;
		fromShapes: fromShapes class new;
		toShapes: toShapes class new
]

{ #category : #DFS }
CTDfsWalker >> recordDfsTimingsOnShape: aShape [

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

{ #category : #accessing }
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

{ #category : #shapes }
CTDfsWalker >> synthesize: object descriptor: descriptor shape: shape slotsRows: slotsRows widths_Association: widths [

	"
	
	s = (self synthesize: object descriptor: descriptor shape: shape slotsRows: slotsRows widths_Association: widths)
	
	iff 
	
	`s` is a RSShape that represents `object` which is described by `descriptor` 
	and has `shape` as box-enclosed slot shapes `slotsRows`, using `widths` 
	as bounds over the x axis.
	
	"

	| defaultShape classShape |
	defaultShape := slotsRows
		                ifEmpty: [ 
			                quotedShapes
				                at: object
				                ifAbsent: [ shapeBuilder multilineLabel: object ] ]
		                ifNotEmpty: [ 
			                RSComposite new
				                model: object;
				                shapes: RSGroup new;
				                extent: 0 @ 0;
				                yourself ].

	classShape := descriptor
		              header: defaultShape model
		              shapeBuilder: shapeBuilder.

	^ shapeBuilder
		  classShape: classShape
		  defaultShape: defaultShape
		  slotsRows: slotsRows
		  widths_Association: widths
		  shape: shape
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
CTDfsWalker >> value: value descriptor: childDescriptor level: level ithChild: ithChild parent: anObject parentShape: aShape widths_Association: widthsExtent metaExtent: metaExtent [

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

{ #category : #shapes }
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

{ #category : #shapes }
CTDfsWalker >> visiting: anObject shape: aShape [

	toShapes at: anObject put: aShape.

	aShape propertyDfsTimings: dfsClock @ -1
]
