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
		'shouldInlineCondition'
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

{ #category : #DFS }
CTDfsWalker >> child: object descriptor: descriptor at: level parent: parent [

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

{ #category : #DFS }
CTDfsWalker >> child: child descriptor: descriptor at: level parent: parent shape: shape widths_Association: widthsAssociation metaExtent: metaExtent [

	| varLabel valueBox extent shouldInline valueLabel |
	varLabel := descriptor
		            varLabelShapeOf: parent
		            shapeBuilder: shapeBuilder.

	valueBox := shapeBuilder box: child.

	shouldInline := CTConditionShouldInline new
		                child: child;
		                descriptor: descriptor;
		                fromShapes: fromShapes;
		                level: level;
		                metaExtent: metaExtent;
		                parent: parent;
		                quotedShapes: quotedShapes;
		                shape: shape;
		                toShapes: toShapes;
		                valueBox: valueBox;
		                walker: self;
		                widthsExtent: widthsAssociation;
		                boolean:
			                (self
				                 shouldInline: child
				                 descriptor: descriptor
				                 at: level).

	extent := shouldInline extent.
	valueLabel := shouldInline valueLabel.

	widthsAssociation
		key: (widthsAssociation key max: varLabel extent x);
		value: (widthsAssociation value max: extent x).

	valueBox height: (extent y max: varLabel extent y).

	^ RSGroupSlotsRow var: varLabel box: valueBox labelOrNil: valueLabel
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
				            child: value
				            descriptor: each
				            at: level
				            parent: object
				            shape: shape
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
CTDfsWalker >> hasBeenVisited: childShape childOfShape: parentShape [

	
]

{ #category : #DFS }
CTDfsWalker >> hasntBeenVisited: child descriptor: descriptor parent: parent shape: shape level: level [

	self incrementDfsClock.

	^ self
		  child: child
		  descriptor: descriptor
		  at: level + 1
		  parent: parent
]

{ #category : #DFS }
CTDfsWalker >> incrementDfsClock [

	^ dfsClock := dfsClock + 1
]

{ #category : #initialization }
CTDfsWalker >> initialize [

	super initialize.

	shouldInlineCondition := CTConditionShouldInline new.

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

	shapeBuilder := aShapeBuilder
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
