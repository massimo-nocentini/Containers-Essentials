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
		'skipBacks',
		'skipNils',
		'skipEmptyCollections',
		'metaExtent'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
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

{ #category : #DFS }
CTDfsWalker >> child: child descriptor: descriptor at: level parent: parent [

	| shape descriptors data |
	shape := shapeBuilder outline: child.

	descriptors := slotDescriptorsContext visit: child.

	data := CTDfsWalkerData new
		        object: child;
		        descriptor: descriptor;
		        level: level;
		        parent: parent;
		        labelsWidth: 0;
		        boxesWidth: metaExtent x;
		        shape: shape;
		        yourself.

	^ self
		  visiting: child shape: shape;
		  atLevel: level putShape: shape;
		  addInteractionsUsingSlotDescriptor: descriptor onShape: shape;
		  collectDescriptors: descriptors data: data;
		  incrementDfsClock;
		  recordDfsTimingsOnShape: shape;
		  synthesize: data
]

{ #category : #DFS }
CTDfsWalker >> child: child descriptor: descriptor data: data [

	| valueLabel varLabel valueBox extent shouldInline |
	varLabel := descriptor
		            varLabelShapeOf: data object
		            shapeBuilder: shapeBuilder.

	valueBox := shapeBuilder box: child.

	shouldInline := self
		                shouldInline: child
		                descriptor: descriptor
		                at: data level.

	shouldInline
		ifTrue: [ 
			| y |
			valueLabel := descriptor shape: child walker: self.

			valueLabel := shapeBuilder pad: valueLabel.

			y := valueLabel extent y max: metaExtent y.

			(quotedShapes includesKey: child) ifTrue: [ 
				valueBox color: Color transparent ].

			extent := valueLabel extent x @ y ]
		ifFalse: [ 
			valueLabel := nil.

			toShapes
				at: child
				ifPresent: [ :anAlreadySeenShape | 
					self hasBeenVisited: anAlreadySeenShape childOfShape: data shape ]
				ifAbsent: [ 
				self hasntBeenVisited: child descriptor: descriptor data: data ].

			descriptor
				isOneToMany: child walker: self;
				addHighlightWithLinesInteractionOnShape: valueBox.

			fromShapes at: valueBox put: data shape.

			valueBox color: valueBox color lighter lighter.

			extent := data boxesWidth @ metaExtent y ].

	data
		labelsWidth: (data labelsWidth max: varLabel extent x);
		boxesWidth: (data boxesWidth max: extent x).

	valueBox height: (extent y max: varLabel extent y).

	^ RSGroupSlotsRow var: varLabel box: valueBox labelOrNil: valueLabel
]

{ #category : #shapes }
CTDfsWalker >> collectDescriptors: descriptors data: data [

	| rows |
	rows := OrderedCollection new.

	descriptors select: [ :each | each enabled ] thenDo: [ :each | 
		| child |
		child := each on: data object walker: self.

		(self shouldSkip: child) ifFalse: [ 
			| slotsRow |
			slotsRow := self child: child descriptor: each data: data.

			rows add: slotsRow ] ].

	data rows: rows
]

{ #category : #shapes }
CTDfsWalker >> defaultShapeFor: object slotsRows: slotsRows [

	^ CTConditionDfsWalkerSlotsRowsEmptyOrNotForSynthesize new
		  object: object;
		  quotedShapes: quotedShapes;
		  shapeBuilder: shapeBuilder;
		  ifEmptyIfNotEmpty: slotsRows
]

{ #category : #accessing }
CTDfsWalker >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #DFS }
CTDfsWalker >> hasBeenVisited: childShape childOfShape: parentShape [

	
]

{ #category : #DFS }
CTDfsWalker >> hasntBeenVisited: child descriptor: descriptor data: data [

	self incrementDfsClock.

	^ self
		  child: child
		  descriptor: descriptor
		  at: data level + 1
		  parent: data object
]

{ #category : #shapes }
CTDfsWalker >> headerShapeFor: object descriptor: descriptor [

	^ descriptor header: object shapeBuilder: shapeBuilder
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
		slotDescriptorsContext: CTSlotDescriptorsVisitor new;
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

	shapeBuilder := aShapeBuilder.

	metaExtent := shapeBuilder metaExtent
]

{ #category : #accessing }
CTDfsWalker >> shouldInline: anObject descriptor: descriptor at: level [

	| boolean |
	boolean := level = maxLevel | anObject isImmediateObject
	           | anObject isNil | anObject isSymbol | (anObject == true)
	           | (anObject == false) | (anObject == Float infinity)
	           | (anObject == Float negativeInfinity).

	^ descriptor inline: anObject level: level default: boolean
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
CTDfsWalker >> synthesize: data [

	"
	
	s = (self synthesize: object descriptor: descriptor shape: shape slotsRows: slotsRows widths_Association: widths)
	
	iff 
	
	`s` is a RSShape that represents `object` which is described by `descriptor` 
	and has `shape` as box-enclosed slot shapes `slotsRows`, using `widths` 
	as bounds over the x axis.
	
	"

	| defaultShape classShape object |
	object := data object.

	defaultShape := data rows
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

	classShape := data descriptor
		              header: defaultShape model
		              shapeBuilder: shapeBuilder.

	^ shapeBuilder
		  classShape: classShape
		  defaultShape: defaultShape
		  data: data
]

{ #category : #accessing }
CTDfsWalker >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #API }
CTDfsWalker >> value: object [

	^ self
		  child: object
		  descriptor: slotDescriptorsContext rootDescriptor
		  at: 1
		  parent: nil
]

{ #category : #shapes }
CTDfsWalker >> visiting: anObject shape: aShape [

	toShapes at: anObject put: aShape.

	aShape propertyDfsTimings: dfsClock @ -1
]
