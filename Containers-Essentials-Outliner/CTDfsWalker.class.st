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
		'shapeBuilder',
		'skipBacks',
		'skipNils',
		'skipEmptyCollections',
		'slotDescriptorsVisitor',
		'defaultShapeBlock',
		'postponedObjects',
		'parents',
		'rootWitness',
		'oneToManyMap'
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
CTDfsWalker >> defaultShapeOf: object descriptor: descriptor [

	^ defaultShapeBlock value: object value: descriptor
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
	data := CTDfsWalkingData new
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

	| s l p m |
	self incrementDfsClock.

	"Unpacking, the short version using compact names."
	s := data shape.
	m := s model.
	l := data level.
	p := data parent.

	toShapes at: m put: s.

	s
		propertyDfsWalkingData: data;
		propertyDfsTimings: dfsClock @ -1;
		propertyDfsDepth: l.

	levels
		at: l
		ifPresent: [ :oc | oc add: s ]
		ifAbsentPut: [ OrderedCollection with: s ].

	parents
		at: m
		ifPresent: [ :oc | oc add: p ]
		ifAbsentPut: [ OrderedCollection with: p ].

	self addInteractionsUsingSlotDescriptor: data descriptor onShape: s
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
	oneToManyMap := IdentityDictionary new.
	parents := IdentityDictionary new.
	rootWitness := Object new.

	self
		maxLevel: 0;
		skipNils: false;
		skipBacks: false;
		skipEmptyCollections: false;
		levels: Dictionary new;
		slotDescriptorsVisitor: CTSlotDescriptorsVisitor new;
		shapeBuilder: CTDfsShapeBuilder new;
		defaultShapeBlock: [ :object :descriptor |
			object asDefaultShapeForWalker: self descriptor: descriptor ]
]

{ #category : #accessing }
CTDfsWalker >> levels: aDictionary [

	levels := aDictionary
]

{ #category : #accessing }
CTDfsWalker >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #accessing }
CTDfsWalker >> oneToManyAt: aBoxShape [

	^ oneToManyMap at: aBoxShape ifAbsent: [ aBoxShape ]
]

{ #category : #accessing }
CTDfsWalker >> parentsOf: anObject [

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
	oneToManyMap := oneToManyMap class new.
	parents := parents class new.

	self
		levels: levels class new;
		fromShapes: fromShapes class new;
		toShapes: toShapes class new
]

{ #category : #dispatched }
CTDfsWalker >> postponedBlockClosure: block backToBlock: backBlock child: child data: data descriptor: descriptor [

	postponedObjects
		at: data rows last box
		put: (backBlock value: self) -> (block value: child)
]

{ #category : #accessing }
CTDfsWalker >> postponedObjects [

	^ postponedObjects
]

{ #category : #dispatched }
CTDfsWalker >> postponedTrue: post child: child data: data descriptor: descriptor [
	"Simply do nothing, proceed as usual delegating to the painter the job of connecting boxes."

	
]

{ #category : #DFS }
CTDfsWalker >> recurring: data [

	| parent objectOutlinerShape l |
	parent := data object.
	objectOutlinerShape := data shape.
	l := data level.

	data exploringDescriptors
		select: [ :each | each isEnabledAtLevel: l ]
		thenDo: [ :each |
			| child |
			child := each valueOn: parent walker: self.

			(self shouldSkip: child) ifFalse: [
				| varLabel valueBox extent inlined rowGroup |
				varLabel := each varShapeOf: parent walker: self.

				valueBox := shapeBuilder box: child.

				rowGroup := RSGroupSlotsRow var: varLabel box: valueBox.

				rowGroup descriptor: each.

				inlined := self shouldInline: child descriptor: each level: l.

				data addRowGroup: rowGroup inlined: inlined.

				inlined
					ifTrue: [
						| y valueLabel |
						valueLabel := each valueShapeOf: child walker: self.

						valueLabel := shapeBuilder pad: valueLabel.

						y := valueLabel extent y max: shapeBuilder metaExtent y.

						(quotedShapes includesKey: child) ifTrue: [
							valueBox
								color: Color transparent;
								noBorder ].

						extent := valueLabel extent x @ y.

						rowGroup label: valueLabel ]
					ifFalse: [
						| isOneToMany |
						isOneToMany := false.

						toShapes
							at: child
							ifPresent: [ :anAlreadySeenShape |
								self
									hasBeenVisited: child
									childShape: anAlreadySeenShape
									parentShape: objectOutlinerShape ]
							ifAbsent: [
								self hasntBeenVisited: child descriptor: each data: data.

								each isOneToMany ifTrue: [
									| childOutliner childSlotRows |
									childOutliner := toShapes removeKey: child.

									childSlotRows := childOutliner propertyDfsWalkingData rows.

									"In order to be one-to-many, each box in the collapsing object has to point outward."
									isOneToMany := childSlotRows allSatisfy: [ :r |
										               r label isNil ].

									isOneToMany ifTrue: [
										childSlotRows do: [ :r | "here we need to associate to each box the parent `valueBox`
											 as well as the parent's outliner, because such information will not keep
											 in the `fromShapes` dictionary to not show such connection by the painter
											 (see the next `isOneToMany ifFalse: [...]` message send."
											oneToManyMap at: r box put: valueBox -> objectOutlinerShape ] ] ] ].

						isOneToMany ifFalse: [
							fromShapes at: valueBox put: objectOutlinerShape ].

						each addHighlightWithLinesInteractionOnShape: valueBox.

						valueBox color: Smalltalk ui theme baseColor translucent.

						extent := data boxesWidth @ shapeBuilder metaExtent y ].

				data
					labelsWidth: (data labelsWidth max: varLabel extent x);
					boxesWidth: (data boxesWidth max: extent x).

				valueBox height: (extent y max: varLabel extent y) ] ].

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
						level: l + 1
						parent: parent
						exploringDescriptors: followers
						shape: outlinerShape.

					ghost := RSComposite ghost: witness.

					fromShapes at: ghost put: objectOutlinerShape ] ]
			walker: self ]
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
CTDfsWalker >> shouldInline: anObject descriptor: descriptor level: level [

	| boolean |
	boolean := level = maxLevel | anObject isImmediateObject
	           | anObject isNil | anObject isSymbol | anObject isString
	           | anObject isFraction | anObject isCompiledMethod
	           | anObject isWolframExpression | anObject isObjectHolder
	           | anObject isNotebookHideReason | (true = anObject)
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
			                ifAbsent: [ self defaultShapeOf: object descriptor: data descriptor ] ]
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
