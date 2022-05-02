Class {
	#name : #CTConditionShouldInline,
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
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTConditionShouldInline >> child: anObject [

	child := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> descriptor: anObject [

	descriptor := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> extent [

	^ extent
]

{ #category : #accessing }
CTConditionShouldInline >> falsehood [

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
CTConditionShouldInline >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTConditionShouldInline >> initialize [

	super initialize.

	hasBeenVisitedConditionHandler := CTConditionHasBeenVisited new.
	quotedShapeBackgroundColorConditionHandler := CTConditionQuotedShapeBackgroundColor
		                                              new
]

{ #category : #accessing }
CTConditionShouldInline >> level: anObject [

	level := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> metaExtent: anObject [

	metaExtent := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> quotedShapes: anObject [

	quotedShapes := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> truthWitness: _ [

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
CTConditionShouldInline >> valueBox: anObject [

	valueBox := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> valueLabel [

	^ valueLabel
]

{ #category : #accessing }
CTConditionShouldInline >> walker: anObject [

	walker := anObject
]

{ #category : #accessing }
CTConditionShouldInline >> widthsExtent: anObject [

	widthsExtent := anObject
]
