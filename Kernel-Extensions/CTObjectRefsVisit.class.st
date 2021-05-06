Class {
	#name : #CTObjectRefsVisit,
	#superclass : #Object,
	#instVars : [
		'toShapes',
		'level',
		'fromShapes',
		'maxLevel',
		'dfsClock',
		'absoluteBoxIndex'
	],
	#category : #'Kernel-Extensions'
}

{ #category : #'as yet unclassified' }
CTObjectRefsVisit >> forObject: anObject slotsMap: selectors [

	| shapes radius descriptors compositeShape extent classLabel boxedCompositeShape nilLabel metaColor metaFontSize mineShape dfsTimes multilineLabelBuilder |
	"Basic settings for rounding the boxes"
	radius := Float e.

	multilineLabelBuilder := RSMultilineLabelBuilder new.

	mineShape := RSComposite new
		             model: anObject;
		             addInteraction: RSDraggable new;
		             propertyAt: #bfsLevel put: level;
		             propertyAt: #dfsTimings put: dfsClock @ -1;
		             "addInteraction: (RSPopup new text: [ :each | 
					              String streamContents: [ :aStream | 
							              aStream
								              nextPutAll: 'BFS level: ';
								              nextPutAll:
									              (mineShape propertyAt: #bfsLevel) asString;
								              cr;
								              nextPutAll: 'DFS timings: ';
								              nextPutAll: dfsTimes asString ] ]);"
			             yourself.

	toShapes at: anObject put: mineShape.

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
		               var := anAssociation key.
		               accessor := anAssociation value.
		               value := accessor value: anObject.

		               valueLabel := (level = maxLevel or: [ 
			                              value isImmediateObject or: [ 
				                              value isNil or: [ value isBoolean ] ] ])
			                             ifTrue: [ 
				                             (multilineLabelBuilder shapeFor:
					                              value) yourself: [ :labelShape | 
					                             extent := extent max:
						                                       labelShape extent ] ]
			                             ifFalse: [ 
				                             (toShapes includesKey: value) 
					                             ifFalse: [ 
						                             level := level + 1.
						                             dfsClock := dfsClock + 1.
						                             self
							                             forObject: value
							                             slotsMap:
							                             value
								                             instVarsNamesOrderedCollection.

						                             level := level - 1 ].
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
			                           propertyAt: #absoluteBoxIndex
			                           put: absoluteBoxIndex;
			                           yourself.

		               absoluteBoxIndex := absoluteBoxIndex + 1.

		               "Our descriptor is a plain dictionary."
		               Dictionary new
			               at: #var put: var;
			               at: #value put: value;
			               at: #valueLabel put: valueLabel;
			               at: #varLabel put: varLabel;
			               at: #valueBox put: valueBox;
			               yourself ].


	dfsClock := dfsClock + 1.
	dfsTimes := mineShape propertyAt: #dfsTimings.
	dfsTimes := mineShape
		            propertyAt: #dfsTimings
		            put: dfsTimes x @ dfsClock.

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
		                       borderDo: [ :border | 
			                       level = 0
				                       ifTrue: [ 
					                       border width: border width double ]
				                       ifFalse: [ border color: metaColor ] ];
		                       yourself.

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

	mineShape shapes: { 
			classLabel.
			boxedCompositeShape }
]

{ #category : #accessing }
CTObjectRefsVisit >> fromShapes: anObject [

	fromShapes := anObject
]

{ #category : #initialization }
CTObjectRefsVisit >> initialize [

	super initialize.

	absoluteBoxIndex := 0.
	dfsClock := 0.
	level := 1.
	maxLevel := -1
]

{ #category : #accessing }
CTObjectRefsVisit >> maxLevel: anObject [

	maxLevel := anObject
]

{ #category : #accessing }
CTObjectRefsVisit >> toShapes: anObject [

	toShapes := anObject
]
