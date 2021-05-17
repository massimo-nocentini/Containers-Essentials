Class {
	#name : #CTObjectRefsVisit,
	#superclass : #Object,
	#instVars : [
		'toShapes',
		'level',
		'fromShapes',
		'maxLevel',
		'dfsClock',
		'sccShapeStack',
		'sccShapeSet',
		'sccs',
		'rootObject',
		'multilineLabelBuilder',
		'sccEdgeStack',
		'bccs'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
CTObjectRefsVisit >> addDraggableInteractionOnShape: mineShape [

	mineShape addInteraction: RSDraggable new
]

{ #category : #visiting }
CTObjectRefsVisit >> addHighlightInteractionOnShape: mineShape [

	mineShape addInteraction:
		(RSHighlightable withStronglyConnectedComponents: [ :shape | 
			 shape propertyDfsSCC collect: [ :each | 
				 each propertyDfsBoxedSlotsShape ] ])
]

{ #category : #visiting }
CTObjectRefsVisit >> addPopupInteractionOnShape: mineShape [

	mineShape addInteraction: (RSPopup new text: [ :each | 
			 String streamContents: [ :aStream | 
				 aStream
					 nextPutAll: 'BFS level: ';
					 nextPutAll: mineShape propertyDfsDepth asString;
					 cr;
					 nextPutAll: 'DFS timings: ';
					 nextPutAll: mineShape propertyDfsTimings asString;
					 cr;
					 nextPutAll: 'SCC lowlink: ';
					 nextPutAll: mineShape propertyDfsLowlink asString;
					 cr;
					 nextPutAll: 'SCC size: ';
					 nextPutAll: mineShape propertyDfsSCC size asString ] ])
]

{ #category : #accessing }
CTObjectRefsVisit >> biConnectedComponents: aCollection [

	bccs := aCollection
]

{ #category : #visiting }
CTObjectRefsVisit >> createBiconnectedComponentIfNecessaryOnShape: childShape childOf: mineShape [

	^ mineShape propertyDfsEntryTime <= childShape propertyDfsLowlink 
		  ifTrue: [ 
			  | bcc assocOfModels fromShape toShape |
			  bcc := bccs add: OrderedCollection new.

			  [ 
			  sccEdgeStack isNotNil and: [ 
				  (toShapes at: sccEdgeStack value key) propertyDfsEntryTime
				  >= childShape propertyDfsEntryTime ] ] whileTrue: [ 
				  assocOfModels := sccEdgeStack value.
				  fromShape := toShapes at: assocOfModels key.
				  toShape := toShapes at: assocOfModels value.
				  bcc add: fromShape -> toShape.
				  fromShape propertyDfsBCC: bcc.
				  toShape propertyDfsBCC: bcc.
				  sccEdgeStack := sccEdgeStack nextLink ].

			  self
				  assert: sccEdgeStack value key == mineShape model;
				  assert: sccEdgeStack value value == childShape model.

			  mineShape propertyIsArticulationObject: true.
			  assocOfModels := sccEdgeStack value.
			  fromShape := toShapes at: assocOfModels key.
			  toShape := toShapes at: assocOfModels value.
			  bcc add: fromShape -> toShape.
			  fromShape propertyDfsBCC: bcc.
			  toShape propertyDfsBCC: bcc.
			  sccEdgeStack := sccEdgeStack nextLink ]
]

{ #category : #visiting }
CTObjectRefsVisit >> createStronglyConnectedComponentIfNecessaryOnShape: mineShape [

	^ mineShape propertyDfsEntryTime = mineShape propertyDfsLowlink 
		  ifTrue: [ 
			  | scc |
			  scc := sccs add: OrderedCollection new.

			  [ 
			  sccShapeStack isNotNil and: [ 
				  sccShapeStack value propertyDfsEntryTime
				  >= mineShape propertyDfsEntryTime ] ] whileTrue: [ 
				  | shape |
				  shape := sccShapeStack value.
				  scc add: shape.
				  shape propertyDfsSCC: scc.
				  sccShapeStack := sccShapeStack nextLink.
				  sccShapeSet remove: shape ].

			  self
				  assert: mineShape propertyDfsSCC == scc;
				  itself: scc ]
]

{ #category : #visiting }
CTObjectRefsVisit >> dfsClockTick [

	dfsClock := dfsClock + 1
]

{ #category : #visiting }
CTObjectRefsVisit >> forObject: anObject ithChild: i of: aParent slotsMap: selectors [

	| descriptors extent classLabel nilLabel metaColor metaFontSize mineShape |
	mineShape := RSComposite new
		             model: anObject;
		             propertyDfsDepth: level;
		             propertyDfsTimings: dfsClock @ -1;
		             propertyDfsLowlink: dfsClock;
		             yourself.

	self
		addDraggableInteractionOnShape: mineShape;
		"addPopupInteractionOnShape: mineShape;"
		addHighlightInteractionOnShape: mineShape.

	toShapes at: anObject put: mineShape.

	sccShapeStack := ValueLink new
		                 value: mineShape;
		                 nextLink: sccShapeStack;
		                 yourself.

	sccShapeSet add: mineShape.

	nilLabel := RSLabel new
		            model: nil;
		            yourself.

	metaColor := nilLabel color lighter lighter lighter.
	metaFontSize := nilLabel fontSize * (Float goldenRatio - 1).

	classLabel := RSLabel new
		              text: anObject class asString;
		              fontSize: metaFontSize;
		              color: metaColor;
		              italic;
		              when: RSMouseLeftClick do: [ :ev | anObject browse ];
		              yourself.


	extent := nilLabel extent.

	descriptors := selectors withIndexCollect: [ :anAssociation :index | 
		               | value valueLabel varLabel valueBox var accessor |
		               anAssociation isSymbol
			               ifTrue: [ 
				               var := anAssociation.
				               accessor := [ :anObj | 
				                           anObj perform: anAssociation ] ]
			               ifFalse: [ 
				               var := anAssociation key.
				               accessor := anAssociation value ].

		               value := accessor value: anObject.

		               valueLabel := level = maxLevel
		                             | value isImmediateObject | value isNil
		                             | value isBoolean | value isSymbol
			                             ifTrue: [ 
				                             (multilineLabelBuilder shapeFor:
					                              value) yourself: [ :labelShape | 
					                             extent := extent max:
						                                       labelShape extent ] ]
			                             ifFalse: [ 
				                             toShapes
					                             at: value
					                             ifPresent: [ :shape | 
						                             | shapeEntryTime |
						                             shapeEntryTime := shape
							                                               propertyDfsEntryTime.
						                             shapeEntryTime
						                             < mineShape propertyDfsEntryTime 
							                             ifTrue: [ 
								                             (sccShapeSet includes: shape) 
									                             ifTrue: [ 
										                             mineShape 
											                             propertyDfsLowlinkUpdate: [ 
											                             :lowlink | 
											                             lowlink min: shapeEntryTime ] ].

								                             anObject ~~ value ifTrue: [ 
									                             sccEdgeStack := ValueLink new
										                                             value:
											                                             anObject
											                                             -> value;
										                                             nextLink:
											                                             sccEdgeStack;
										                                             yourself.

									                             mineShape 
										                             propertyDfsLowlinkUpdate: [ 
										                             :lowlink | 
										                             lowlink min: shapeEntryTime ] ] ] ]
					                             ifAbsent: [ 
						                             sccEdgeStack := ValueLink new
							                                             value:
								                                             anObject -> value;
							                                             nextLink:
								                                             sccEdgeStack;
							                                             yourself.
						                             self
							                             dfsClockTick;
							                             withFurtherLevelDo: [ 
								                             | childShape |
								                             childShape := self
									                                           forObject: value
									                                           ithChild: index
									                                           of: anObject
									                                           slotsMap:
										                                           value
											                                           instVarsNamesOrderedCollection.

								                             mineShape 
									                             propertyDfsLowlinkUpdate: [ 
										                             :lowlink | 
										                             lowlink min:
												                             childShape propertyDfsLowlink ].

								                             self
									                             createBiconnectedComponentIfNecessaryOnShape:
										                             childShape
									                             childOf: mineShape ] ].
				                             nil ].

		               varLabel := RSLabel new
			                           model: var;
			                           color: metaColor;
			                           yourself.

		               valueBox := RSBox new
			                           model: value;
			                           color: Color white;
			                           cornerRadius: self radiusOrPadding;
			                           withBorder;
			                           addInteraction:
				                           RSHighlightable withLines;
			                           yourself.

		               "Our descriptor is a plain dictionary."
		               Dictionary new
			               at: #var put: var;
			               at: #value put: value;
			               at: #valueLabel put: valueLabel;
			               at: #varLabel put: varLabel;
			               at: #valueBox put: valueBox;
			               yourself ].


	self dfsClockTick.

	mineShape propertyDfsTimings:
		mineShape propertyDfsEntryTime @ dfsClock.

	^ self
		  createStronglyConnectedComponentIfNecessaryOnShape: mineShape;
		  object: anObject
		  descriptors: descriptors
		  extent: self radiusOrPadding + extent x @ extent y
		  shape: mineShape
		  classLabel: classLabel
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTObjectRefsVisit >> initialize [

	super initialize.

	dfsClock := 0.
	level := 1.
	maxLevel := 0.
	sccShapeStack := nil.
	sccEdgeStack := nil.
	sccShapeSet := IdentitySet new.
	sccs := OrderedCollection new.
	bccs := OrderedCollection new.

	multilineLabelBuilder := RSMultilineLabelBuilder new
]

{ #category : #accessing }
CTObjectRefsVisit >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #visiting }
CTObjectRefsVisit >> object: anObject descriptors: descriptors extent: extent shape: mineShape classLabel: classLabel [

	| shapes boxedCompositeShape compositeShape |
	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel value valueShape |
		          "Unpacking."
		          value := slotDescriptor at: #value.
		          varLabel := slotDescriptor at: #varLabel.
		          valueLabel := slotDescriptor at: #valueLabel.
		          valueBox := slotDescriptor at: #valueBox.

		          valueBox extent: extent.

		          valueShape := valueLabel
			                        ifNil: [ 
				                        fromShapes at: valueBox put: mineShape.
				                        valueBox ]
			                        ifNotNil: [ 
				                        RSLocation new
					                        inner;
					                        stick: valueLabel on: valueBox.
				                        RSComposite new
					                        shapes:
						                        (Array with: valueBox with: valueLabel);
					                        yourself ].

		          RSLocation new
			          left;
			          outer;
			          offset: self radiusOrPadding negated @ 0;
			          stick: varLabel on: valueShape.

		          RSComposite new
			          shapes: (Array with: varLabel with: valueShape);
			          yourself ].

	RSVerticalLineLayout new
		verticalGap: 0;
		on: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	shapes ifEmpty: [ 
		| label |
		label := (multilineLabelBuilder shapeFor: anObject) yourself: [ :l | 
			         l extent: (l extent max: classLabel extent) ].
		shapes := Array with: label ].

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: self radiusOrPadding;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent:
			                       (compositeShape extent max:
					                        classLabel extent);
		                       cornerRadius: self radiusOrPadding;
		                       borderDo: [ :aBorder | 
			                       mineShape propertyIsArticulationObject 
				                       ifTrue: [ 
					                       aBorder
						                       width: Float goldenRatio;
						                       color: Color red translucent ] ];
		                       yourself.

	mineShape propertyDfsBoxedSlotsShape: boxedCompositeShape.

	RSLocation new inner right
		stick: compositeShape
		on: boxedCompositeShape.

	boxedCompositeShape := RSComposite new
		                       shapes: { 
				                       boxedCompositeShape.
				                       compositeShape };
		                       yourself.

	RSLocation new
		above;
		stick: classLabel on: boxedCompositeShape.

	RSAlignment new
		shapes: { 
				classLabel.
				boxedCompositeShape };
		left.

	^ mineShape
		  shapes: { 
				  classLabel.
				  boxedCompositeShape };
		  padding: self radiusOrPadding;
		  yourself
]

{ #category : #visiting }
CTObjectRefsVisit >> radiusOrPadding [

	^ Float goldenRatio double
]

{ #category : #accessing }
CTObjectRefsVisit >> rootObject [

	^ rootObject
]

{ #category : #accessing }
CTObjectRefsVisit >> rootObject: anObject [

	rootObject := anObject
]

{ #category : #accessing }
CTObjectRefsVisit >> stronglyConnectedComponents: aCollection [

	sccs := aCollection
]

{ #category : #accessing }
CTObjectRefsVisit >> toShapes: anObject [

	toShapes := anObject
]

{ #category : #evaluating }
CTObjectRefsVisit >> value [

	| aShape |
	aShape := self
		          forObject: rootObject
		          ithChild: -1
		          of: nil
		          slotsMap: rootObject instVarsNamesOrderedCollection.

	^ self
		  assert: sccShapeStack isNil;
		  assert: sccEdgeStack isNil;
		  itself: aShape
]

{ #category : #visiting }
CTObjectRefsVisit >> withFurtherLevelDo: aBlock [

	level := level + 1.
	^ aBlock value yourself: [ level := level - 1 ]
]
