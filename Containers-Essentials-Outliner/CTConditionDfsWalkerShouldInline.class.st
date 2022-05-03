Class {
	#name : #CTConditionDfsWalkerShouldInline,
	#superclass : #CTCondition,
	#instVars : [
		'descriptor',
		'child',
		'valueLabel',
		'metaExtent',
		'quotedShapeBackgroundColorConditionHandler',
		'quotedShapes',
		'valueBox',
		'extent',
		'hasBeenVisitedConditionHandler',
		'walker',
		'parent',
		'shape',
		'level',
		'toShapes',
		'fromShapes',
		'widthsExtent'
	],
	#category : #'Containers-Essentials-Outliner-Walkers'
}

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> extent [

	^ extent
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> falsehood [

	valueLabel := nil.

	hasBeenVisitedConditionHandler
		walker: walker;
		child: child;
		descriptor: descriptor;
		parent: parent;
		shape: shape;
		level: level;
		lookupInDictionary: toShapes at: child.

	descriptor
		isOneToMany: child walker: walker;
		addHighlightWithLinesInteractionOnShape: valueBox.

	fromShapes at: valueBox put: shape.

	valueBox color: valueBox color lighter lighter.

	extent := widthsExtent value @ metaExtent y
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTConditionDfsWalkerShouldInline >> initialize [

	super initialize.

	hasBeenVisitedConditionHandler := CTConditionDfsWalkerHasBeenVisited new.
	quotedShapeBackgroundColorConditionHandler := CTConditionDfsWalkerQuotedShapeBackgroundColor
		                                              new
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> metaExtent: anObject [

	metaExtent := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> quotedShapes: anObject [

	quotedShapes := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> truthWitness: _ [

	| y |
	valueLabel := descriptor shape: child walker: walker.

	valueLabel := walker shapeBuilder pad: valueLabel.

	y := valueLabel extent y max: metaExtent y.

	quotedShapeBackgroundColorConditionHandler
		ifTrueIfFalse: (quotedShapes includesKey: child)
		truthWitness: valueBox.

	extent := valueLabel extent x @ y
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> valueBox: anObject [

	valueBox := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> valueLabel [

	^ valueLabel
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> walker: anObject [

	walker := anObject
]

{ #category : #accessing }
CTConditionDfsWalkerShouldInline >> widthsExtent: anObject [

	widthsExtent := anObject
]
