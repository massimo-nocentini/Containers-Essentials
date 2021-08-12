Class {
	#name : #BlockSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'selector',
		'inline',
		'header',
		'isOneToMany',
		'metaColor',
		'metaFontSize',
		'metaExtent',
		'prototypeLabel'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
BlockSlotDescriptor >> addDraggableInteractionOnShape: aShape [

	aShape addInteraction: RSDraggable new
]

{ #category : #visiting }
BlockSlotDescriptor >> addHighlightInteractionOnShape: aShape [

	aShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
BlockSlotDescriptor >> addPopupInteractionOnShape: aShape [

	aShape addInteraction: (RSPopup new text: [ :each | 
			 String streamContents: [ :aStream | 
				 aStream
					 nextPutAll: 'BFS level: ';
					 nextPutAll: aShape propertyDfsDepth asString;
					 cr;
					 nextPutAll: 'DFS timings: ';
					 nextPutAll: aShape propertyDfsTimings asString;
					 cr;
					 nextPutAll: 'SCC lowlink: ';
					 nextPutAll: aShape propertyDfsLowlink asString;
					 cr;
					 nextPutAll: 'SCC size: ';
					 nextPutAll: aShape propertyDfsSCC size asString ] ])
]

{ #category : #accessing }
BlockSlotDescriptor >> addQuotedShapeInVisit: quotedShapes [

	"Nothing to do because I don't have a quoted shape."

	
]

{ #category : #accessing }
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #visiting }
BlockSlotDescriptor >> boxShapeOf: aValue [

	"self assert: aValue == value."

	^ RSBox new
		  model: aValue;
		  color: metaColor translucent lighter lighter;
		  cornerRadius: self radiusOrPadding;
		  withBorder;
		  yourself
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
BlockSlotDescriptor >> headerWithAllSuperclasses [

	self header: [ :anObject | 
		anObject class asShapeAllSuperclassesIndented: [ :each | 
			self labelForClass: each ] ]
]

{ #category : #initialization }
BlockSlotDescriptor >> headerWithClass [

	self header: [ :anObject | 
		anObject class asShapeClass: [ :each | self labelForClass: each ] ]
]

{ #category : #initialization }
BlockSlotDescriptor >> initialize [

	super initialize.

	self
		prototypeLabel: (RSLabel new
				 model: nil;
				 fontName: 'Source Code Pro';
				 yourself);
		oneToOne;
		headerWithAllSuperclasses;
		inline: [ :anObject :level :aBoolean | aBoolean ];
		selectorHasBeenGiven
]

{ #category : #dispatching }
BlockSlotDescriptor >> inline: aController [

	aController inlineFromSlotDescriptor: self
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> inline: anObject level: level default: aBoolean [

	^ inline value: anObject value: level value: aBoolean
]

{ #category : #dispatched }
BlockSlotDescriptor >> inlineBlockClosure: aBlock [

	inline := aBlock
]

{ #category : #dispatched }
BlockSlotDescriptor >> inlineBoolean: aBoolean [

	self inlineBlockClosure: [ :anObject :level :default | aBoolean ]
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
BlockSlotDescriptor >> labelForClass: aClass [

	^ RSLabel new
		  text: aClass name;
		  fontSize: metaFontSize;
		  color: metaColor;
		  when: RSMouseLeftClick do: [ :ev | aClass browse ];
		  yourself: [ :labelShape | 
			  aClass hasAbstractMethods ifTrue: [ labelShape italic ] ]
]

{ #category : #accessing }
BlockSlotDescriptor >> metaExtent [

	^ metaExtent
]

{ #category : #initialization }
BlockSlotDescriptor >> multilineLabelShapeOf: anObject [

	^ anObject asString asMultilineLabelShape: prototypeLabel
]

{ #category : #initialization }
BlockSlotDescriptor >> noHeader [

	self header: [ :anObject | RSBoundingShape nilShape ]
]

{ #category : #accessing }
BlockSlotDescriptor >> on: anObject [

	value := blockClosure cull: anObject cull: self selector
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToMany [

	isOneToMany := true
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> oneToOne [

	isOneToMany := false
]

{ #category : #initialization }
BlockSlotDescriptor >> prototypeLabel: aLabel [

	(prototypeLabel := aLabel) withText: '...' do: [ 
		metaExtent := prototypeLabel extent.
		metaColor := prototypeLabel color lighter lighter lighter.
		metaFontSize := prototypeLabel fontSize * Float silverRatio ]
]

{ #category : #visiting }
BlockSlotDescriptor >> radiusOrPadding [

	^ Float goldenRatio double
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
BlockSlotDescriptor >> shape [

	^ value asString asMultilineLabelShape: prototypeLabel
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> varLabelShapeOf: anObject [

	| composite aBlock var |
	var := self selector.
	composite := var asString asMultilineLabelShape: (RSLabel new
			              color: metaColor;
			              yourself).

	RSAlignment new
		shapes: composite shapes;
		right.

	aBlock := (anObject class lookupSelector: var)
		          ifNil: [ [ :ev |  ] ]
		          ifNotNil: [ :cm | 
			          cm firstComment ifNotEmpty: [ :firstComment | 
				          | popup |
				          popup := RSPopup new
					                   shapeBuilder: [ :aComment | 
						                   | commentComposite box |
						                   commentComposite := aComment 
							                                       asMultilineLabelShape:
								                                       prototypeLabel.

						                   box := RSBox new
							                          withBorder;
							                          color: Color veryVeryLightGray;
							                          cornerRadius: Float goldenRatio * 2;
							                          extent:
								                          commentComposite extent
								                          + (Float goldenRatio * 4).

						                   RSLocation new center
							                   stick: commentComposite
							                   on: box.

						                   RSComposite new
							                   shapes: { 
									                   box.
									                   commentComposite };
							                   yourself ];
					                   model: firstComment;
					                   yourself.

				          composite addInteraction: popup ].
			          [ :ev | cm browse ] ].
	^ composite
		  when: RSMouseLeftClick do: aBlock;
		  yourself
]
