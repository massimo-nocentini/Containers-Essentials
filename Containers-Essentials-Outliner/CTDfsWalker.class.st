"
I walk a graph of objects according to the Depth-First Search strategy.

# Instance variables

- toShapes 
- fromShapes 
- maxLevel 
- dfsClock 
- levels 
- quotedShapes 
- oneToManyShapes
- shapeBuilder
- skipBacks
- skipNils
- skipEmptyCollections
- slotDescriptorsVisitor
- defaultShapeBlock
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
		'oneToManyShapes',
		'shapeBuilder',
		'skipBacks',
		'skipNils',
		'skipEmptyCollections',
		'slotDescriptorsVisitor',
		'defaultShapeBlock'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #shapes }
CTDfsWalker >> addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape [

	aShape addInteraction: RSDraggable new
	"aDescriptor addPopupInteractionOnShape: wholeShape"
]

{ #category : #shapes }
CTDfsWalker >> addQuotedShape: shape model: value [

	quotedShapes at: value put: shape
]

{ #category : #accessing }
CTDfsWalker >> defaultShapeBlock: aBlock [

	defaultShapeBlock := aBlock
]

{ #category : #shapes }
CTDfsWalker >> defaultShapeOf: object [

	^ defaultShapeBlock value: object
]

{ #category : #DFS }
CTDfsWalker >> descriptor: descriptor object: object level: level parent: parent [

	| shape descriptors |
	shape := shapeBuilder outline: object.
	
	descriptors := slotDescriptorsVisitor visit: object.

	^ self
		  descriptor: descriptor
		  object: object
		  level: level
		  parent: parent
		  exploringDescriptors: descriptors
		  shape: shape
]

{ #category : #DFS }
CTDfsWalker >> descriptor: descriptor object: object level: level parent: parent exploringDescriptors: descriptors shape: shape [

	| data |
	data := CTDfsWalkerData new
		        object: object;
		        descriptor: descriptor;
		        level: level;
		        parent: parent;
		        labelsWidth: 0.0;
		        boxesWidth: shapeBuilder metaExtent x;
		        shape: shape;
		        hasOutgoings: false;
		        exploringDescriptors: descriptors;
		        yourself.

	^ self
		  entering: data;
		  recurring: data;
		  exiting: data;
		  synthesizing: data
]

{ #category : #DFS }
CTDfsWalker >> entering: data [

	self
		incrementDfsClock;
		enteringShape: data shape atLevel: data level.

	self
		addInteractionsUsingSlotDescriptor: data descriptor
		onShape: data shape
]

{ #category : #shapes }
CTDfsWalker >> enteringShape: shape atLevel: depth [

	| level |
	toShapes at: shape model put: shape.

	shape
		propertyDfsTimings: dfsClock @ -1;
		propertyDfsDepth: depth.

	level := levels at: depth ifAbsentPut: [ OrderedCollection new ].

	level add: shape
]

{ #category : #DFS }
CTDfsWalker >> exiting: data [

	self incrementDfsClock.

	data shape propertyDfsTimings:
		data shape propertyDfsEntryTime @ dfsClock
]

{ #category : #accessing }
CTDfsWalker >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #DFS }
CTDfsWalker >> hasBeenVisited: child childShape: childShape parentShape: parentShape [

	
]

{ #category : #DFS }
CTDfsWalker >> hasntBeenVisited: child descriptor: descriptor data: data [

	descriptor postponed ifFalse: [
		self
			descriptor: descriptor
			object: child
			level: data level + 1
			parent: data object ].

	data hasOutgoings:
		(data hasOutgoings or: [ toShapes includesKey: child ])
]

{ #category : #DFS }
CTDfsWalker >> incrementDfsClock [

	dfsClock := dfsClock + 1
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
		slotDescriptorsVisitor: CTSlotDescriptorsVisitor new;
		shapeBuilder: CTDfsShapeBuilder new;
		defaultShapeBlock: [ :object | object asDefaultShapeForWalker: self ]
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
CTDfsWalker >> recurring: data [

	| parent |
	parent := data object.

	data exploringDescriptors
		select: [ :each | each enabled ]
		thenDo: [ :each |
			| child |
			child := each valueOn: parent walker: self.

			(self shouldSkip: child) ifFalse: [
				self recurring: data child: child descriptor: each ] ].

	data hasOutgoings ifFalse: [
		data descriptor
			ifHasFollowers: [ :anArray :parentDescriptor |
				anArray do: [ :followers |
					| witness ghost outlinerShape model |
					witness := Object new.

					model := (quotedShapes
						          at: parent
						          ifAbsent: [ toShapes at: parent ]) model.

					outlinerShape := shapeBuilder outline: witness.

					self
						descriptor: parentDescriptor
						object: model
						level: data level + 1
						parent: parent
						exploringDescriptors: followers
						shape: outlinerShape.

					ghost := RSComposite ghost: witness.

					self registerSlotShape: ghost intoOutlineShape: data shape ] ]
			walker: self ]
]

{ #category : #DFS }
CTDfsWalker >> recurring: data child: child descriptor: descriptor [

	| valueLabel varLabel valueBox extent inlined rowsGroup |
	varLabel := descriptor varShapeOf: data object dfsWalker: self.

	valueBox := shapeBuilder box: child.

	inlined := self
		           shouldInline: child
		           descriptor: descriptor
		           level: data level.

	inlined
		ifTrue: [
			| y |
			valueLabel := descriptor shape: child walker: self.

			valueLabel := shapeBuilder pad: valueLabel.

			y := valueLabel extent y max: shapeBuilder metaExtent y.

			(quotedShapes includesKey: child) ifTrue: [
				valueBox color: Color transparent ].

			extent := valueLabel extent x @ y ]
		ifFalse: [
			valueLabel := nil.

			toShapes
				at: child
				ifPresent: [ :anAlreadySeenShape |
					self
						hasBeenVisited: child
						childShape: anAlreadySeenShape
						parentShape: data shape ]
				ifAbsent: [
				self hasntBeenVisited: child descriptor: descriptor data: data ].

			descriptor
				isOneToMany: child walker: self;
				addHighlightWithLinesInteractionOnShape: valueBox.

			self registerSlotShape: valueBox intoOutlineShape: data shape.

			valueBox color: valueBox color lighter lighter.

			extent := data boxesWidth @ shapeBuilder metaExtent y ].

	data
		labelsWidth: (data labelsWidth max: varLabel extent x);
		boxesWidth: (data boxesWidth max: extent x).

	valueBox height: (extent y max: varLabel extent y).

	rowsGroup := RSGroupSlotsRow
		             var: varLabel
		             box: valueBox
		             labelOrNil: valueLabel.

	data addRowGroup: rowsGroup inlined: inlined
]

{ #category : #shapes }
CTDfsWalker >> registerSlotShape: slotShape intoOutlineShape: outlineShape [

	fromShapes at: slotShape put: outlineShape
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
CTDfsWalker >> shouldInline: anObject descriptor: descriptor level: level [

	| boolean |
	boolean := level = maxLevel | anObject isImmediateObject
	           | anObject isNil | anObject isSymbol | anObject isString
	           | anObject isFraction | (true = anObject)
	           | (false = anObject) | (Float infinity = anObject)
	           | (Float negativeInfinity = anObject).

	^ descriptor inline: anObject level: level default: boolean
]

{ #category : #accessing }
CTDfsWalker >> shouldSkip: value [

	^ (skipNils and: [ value isNil ]) or: [
		  (skipBacks and: [ toShapes includesKey: value ]) or: [
			  skipEmptyCollections and: [
				  value isCollection and: [ value isEmpty ] ] ] ]
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
CTDfsWalker >> slotDescriptorsVisitor: aBlock [

	slotDescriptorsVisitor := aBlock
]

{ #category : #shapes }
CTDfsWalker >> synthesizing: data [

	| defaultShape classShape object |
	object := data object.

	defaultShape := data rows
		                ifEmpty: [ 
		                quotedShapes
			                at: object
			                ifAbsent: [ self defaultShapeOf: object ] ]
		                ifNotEmpty: [ RSComposite ghost: object ].

	classShape := data descriptor header: defaultShape model walker: self.

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
		  descriptor: slotDescriptorsVisitor rootDescriptor
		  object: object
		  level: 1
		  parent: Object new
]
