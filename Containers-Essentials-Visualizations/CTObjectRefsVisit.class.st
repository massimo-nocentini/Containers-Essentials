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
		'rootObject'
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

{ #category : #visiting }
CTObjectRefsVisit >> dfsClockTick [

	dfsClock := dfsClock + 1
]

{ #category : #visiting }
CTObjectRefsVisit >> forObject: anObject slotsMap: selectors [

	| shapes radius descriptors compositeShape extent classLabel boxedCompositeShape nilLabel metaColor metaFontSize mineShape multilineLabelBuilder |
	"Basic settings for rounding the boxes"
	radius := Float e.

	multilineLabelBuilder := RSMultilineLabelBuilder new.

	mineShape := RSComposite new
		             model: anObject;
		             propertyDfsDepth: level;
		             propertyDfsTimings: dfsClock @ -1;
		             propertyDfsLowlink: dfsClock;
		             yourself.

	self
		addDraggableInteractionOnShape: mineShape;
		addPopupInteractionOnShape: mineShape;
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
		              model: anObject class;
		              fontSize: metaFontSize;
		              color: metaColor;
		              italic;
		              yourself.

	extent := nilLabel extent.

	descriptors := selectors collect: [ :anAssociation | 
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
				                             (toShapes includesKey: value)
					                             ifTrue: [ 
						                             | shape shapeEntryTime |
						                             shape := toShapes at: value.
						                             shapeEntryTime := shape
							                                               propertyDfsEntryTime.
						                             (shapeEntryTime
						                              < mineShape propertyDfsEntryTime 
							                              and: [ 
							                              sccShapeSet includes: shape ]) 
							                             ifTrue: [ 
								                             mineShape 
									                             propertyDfsLowlinkUpdate: [ 
									                             :lowlink | 
									                             lowlink min: shapeEntryTime ] ] ]
					                             ifFalse: [ 
						                             self
							                             dfsClockTick;
							                             withFurtherLevelDo: [ 
								                             self
									                             forObject: value
									                             slotsMap:
										                             value
											                             instVarsNamesOrderedCollection ].

						                             mineShape 
							                             propertyDfsLowlinkUpdate: [ 
							                             :lowlink | 
							                             lowlink min:
								                             (toShapes at: value)
									                             propertyDfsLowlink ] ].
				                             nil ].

		               varLabel := RSLabel new
			                           model: var;
			                           color: metaColor;
			                           yourself.

		               valueBox := RSBox new
			                           model: value;
			                           color: Color white;
			                           cornerRadius: radius;
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

	mineShape propertyDfsEntryTime = mineShape propertyDfsLowlink 
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

			self assert: mineShape propertyDfsSCC == scc ].

	extent := radius double + extent x @ extent y.

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
			          offset: radius negated @ 0;
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
		                  padding: radius;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent:
			                       (compositeShape extent max:
					                        classLabel extent);
		                       cornerRadius: radius;
		                       withBorder;
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

	mineShape
		shapes: { 
				classLabel.
				boxedCompositeShape };
		padding: 2
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
	sccShapeSet := IdentitySet new.
	sccs := OrderedCollection new
]

{ #category : #accessing }
CTObjectRefsVisit >> maxLevel: anObject [

	maxLevel := anObject
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

	^ self
		  forObject: rootObject
		  slotsMap: rootObject instVarsNamesOrderedCollection
]

{ #category : #visiting }
CTObjectRefsVisit >> withFurtherLevelDo: aBlock [

	level := level + 1.
	^ aBlock value yourself: [ level := level - 1 ]
]
