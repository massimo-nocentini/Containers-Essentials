"
I walk a graph of objects according to the Depth-First Search strategy.

The entry point of the computation is `CTDfsWalker>>#value:`

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
		'defaultShapeBlock',
		'postponedObjects',
		'parents'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #shapes }
CTDfsWalker >> addInteractionsUsingSlotDescriptor: aDescriptor onShape: aShape [

	"aShape addInteraction: RSDraggable new"
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

	data shape propertyAt: #dfsWalkerData put: data.

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

	descriptor
		dispatchPostponed: child
		data: data
		walker: self
		otherwise: [
			self
				descriptor: descriptor
				object: child
				level: data level + 1
				parent: data object.

			data hasOutgoings:
				(data hasOutgoings or: [ toShapes includesKey: child ]) ]
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
	postponedObjects := IdentityDictionary new.
	parents := IdentityDictionary new.

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

{ #category : #accessing }
CTDfsWalker >> parentOf: anObject [

	^ parents at: anObject
]

{ #category : #copying }
CTDfsWalker >> postCopy [

	super postCopy.

	"Both the dfs clock and the shapes stack is managed locally, so
	 no client of me can interact with these data."
	dfsClock := 0.

	"The handling of quoted shapes is my own responsibility only."
	quotedShapes := quotedShapes class new.
	postponedObjects := postponedObjects class new.
	parents := parents class new.

	self
		levels: levels class new;
		oneToManyShapes: oneToManyShapes class new;
		fromShapes: fromShapes class new;
		toShapes: toShapes class new
]

{ #category : #DFS }
CTDfsWalker >> postponedBlockClosure: block child: child data: data descriptor: descriptor [

	postponedObjects
		at: data rows last box
		put: data object -> (block value: child)
]

{ #category : #DFS }
CTDfsWalker >> postponedObjects [

	^ postponedObjects
]

{ #category : #DFS }
CTDfsWalker >> postponedTrue: post child: child data: data descriptor: descriptor [
	"Simply do nothing, proceed as usual delegating to the painter the job of connecting boxes."

	
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
				parents
					at: child
					ifPresent: [ ]
					ifAbsentPut: [ parent ].

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

	| varLabel valueBox extent inlined rowGroup |
	varLabel := descriptor varShapeOf: data object walker: self.

	valueBox := shapeBuilder box: child.

	inlined := self
		           shouldInline: child
		           descriptor: descriptor
		           level: data level.

	rowGroup := RSGroupSlotsRow var: varLabel box: valueBox.

	data addRowGroup: rowGroup inlined: inlined.

	inlined
		ifTrue: [
			| y valueLabel |
			valueLabel := descriptor valueShapeOf: child walker: self.

			valueLabel := shapeBuilder pad: valueLabel.

			y := valueLabel extent y max: shapeBuilder metaExtent y.

			(quotedShapes includesKey: child) ifTrue: [
				valueBox color: Color transparent ].

			extent := valueLabel extent x @ y.

			rowGroup label: valueLabel ]
		ifFalse: [
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

	valueBox height: (extent y max: varLabel extent y)
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
