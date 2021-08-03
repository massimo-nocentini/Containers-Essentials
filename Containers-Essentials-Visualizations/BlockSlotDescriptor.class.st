Class {
	#name : #BlockSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'selector',
		'inline',
		'header',
		'isOneToMany'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
BlockSlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	"Nothing to do because I don't have a quoted shape."

	
]

{ #category : #accessing }
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #accessing }
BlockSlotDescriptor >> header [

	^ header
]

{ #category : #accessing }
BlockSlotDescriptor >> header: aBlock [

	header := aBlock
]

{ #category : #initialization }
BlockSlotDescriptor >> initialize [

	super initialize.

	self
		oneToOne;
		header: [ :anObject :metaFontSize :metaColor | 
			anObject class asShapeAllSuperclassesIndented: [ :each | 
					RSLabel new
						text: each name;
						fontSize: metaFontSize;
						color: metaColor;
						when: RSMouseLeftClick do: [ :ev | each browse ];
						yourself: [ :labelShape | 
							each hasAbstractMethods ifTrue: [ labelShape italic ] ] ] ];
		inline: nil;
		selectorHasBeenGiven
]

{ #category : #accessing }
BlockSlotDescriptor >> inline: aController [

	inline := aController inlineBlock
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> instVarNameHasBeenGiven [

	self blockClosure: [ :anObj :varName | anObj instVarNamed: varName ]
]

{ #category : #testing }
BlockSlotDescriptor >> isOneToManyFromVisit: aVisit [

	isOneToMany ifTrue: [ aVisit oneToMany: self value ]
]

{ #category : #initialization }
BlockSlotDescriptor >> noHeader [

	self header: [ :anObject :metaFontSize :metaColor | 
		RSComposite new
			extent: 0 asPoint;
			yourself ]
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToOne [

	isOneToMany := false
]

{ #category : #accessing }
BlockSlotDescriptor >> selector [

	^ selector
]

{ #category : #accessing }
BlockSlotDescriptor >> selector: anObject [

	selector := anObject
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> selectorHasBeenGiven [

	self blockClosure: [ :anObj :aSelector | anObj perform: aSelector ]
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> shapeWithPrototypeLabel: prototypeLabel [

	^ value asString asMultilineLabelShape: prototypeLabel
]

{ #category : #accessing }
BlockSlotDescriptor >> value: anObject [

	^ value := blockClosure cull: anObject cull: self selector
]
