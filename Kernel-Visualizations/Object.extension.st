Extension { #name : #Object }

{ #category : #'*Kernel-Visualizations' }
Object >> asShapeWithAccessorsMap: accessors fromBoxShapes: boxes [

	| shapes radious descriptors selectors compositeShape extent aSet |
	"Basic settings for rounding the boxes"
	radious := 2.
	selectors := self instVarsNamesOrderedCollection.

	extent := RSLabel new
		          model: nil;
		          extent.

	descriptors := selectors collect: [ :anAssociation | 
		               | value varLabel valueBox accessor model selectorOrVarName |
		               selectorOrVarName := anAssociation key.
		               value := [ self perform: selectorOrVarName ]
			                        onDNU: selectorOrVarName
			                        do: [ :e | 
			                        self instVarNamed: selectorOrVarName ].
		               accessor := anAssociation value.
		               value := accessor value: self.

		               model := (aSet includes: value) ifFalse: [ value ].

		               varLabel := RSLabel new
			                           model: selectorOrVarName;
			                           yourself.
		               varLabel color: varLabel color lighter lighter.

		               valueBox := RSBox new
			                           model: value;
			                           color: Color white;
			                           cornerRadius: 2;
			                           withBorder;
			                           yourself.

		               "Our descriptor is a plain dictionary."
		               Dictionary new
			               at: #var put: selectorOrVarName;
			               at: #value put: value;
			               at: #varLabel put: varLabel;
			               at: #valueBox put: valueBox;
			               yourself ].

	extent := extent x * 3 / 2 @ extent y.

	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel value valueShape slotShape |
		          "Unpacking."
		          value := slotDescriptor at: #value.
		          varLabel := slotDescriptor at: #varLabel.
		          valueLabel := slotDescriptor at: #valueLabel.
		          valueBox := slotDescriptor at: #valueBox.

		          valueBox extent: extent.

		          valueShape := valueLabel ifNil: [ valueBox ] ifNotNil: [ 
			                        RSLocation new
				                        inner;
				                        stick: valueLabel on: valueBox.
			                        RSComposite new
				                        model: value asString -> value;
				                        shapes:
					                        (Array with: valueBox with: valueLabel);
				                        adjustToChildren;
				                        yourself ].

		          RSLocation new
			          left;
			          outer;
			          offset: -2 @ 0;
			          move: varLabel on: valueShape.

		          slotShape := RSComposite new
			                       model:
				                       (slotDescriptor at: #var)
				                       -> valueShape model;
			                       shapes:
				                       (Array with: varLabel with: valueShape);
			                       yourself ].

	RSVerticalLineLayout new
		verticalGap: 0;
		on: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: 2;
		                  yourself.

	^ RSGroup new
		  add: compositeShape;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupKnownReferences: aSet [

	| shapes radious descriptors selectors compositeShape extent |
	"Basic settings for rounding the boxes"
	radious := 2.
	selectors := self instVarsNamesOrderedCollection.

	extent := RSLabel new
		          model: nil;
		          extent.

	descriptors := selectors collect: [ :anAssociation | 
		               | value valueLabel varLabel valueBox var accessor |
		               var := anAssociation key.
		               accessor := anAssociation value.
		               value := accessor value: self.

		               valueLabel := (value isImmediateObject or: [ 
			                              value isNil ])
			                             ifTrue: [ 
				                             RSLabel new
					                             model: value asString;
					                             yourself: [ :labelShape | 
						                             extent := extent max:
								                                       labelShape extent ] ]
			                             ifFalse: [ nil ].

		               varLabel := RSLabel new
			                           model: var;
			                           yourself: [ :aShape | 
				                           aShape color:
						                           aShape color lighter lighter ].

		               valueBox := RSBox new
			                           model: value;
			                           color: Color white;
			                           cornerRadius: 2;
			                           withBorder;
			                           yourself.

		               "Our descriptor is a plain dictionary."
		               Dictionary new
			               at: #var put: var;
			               at: #value put: value;
			               at: #valueLabel put: valueLabel;
			               at: #varLabel put: varLabel;
			               at: #valueBox put: valueBox;
			               yourself ].

	extent := extent x * 3 / 2 @ extent y.

	shapes := descriptors collect: [ :slotDescriptor | 
		          | varLabel valueBox valueLabel value valueShape slotShape |
		          "Unpacking."
		          value := slotDescriptor at: #value.
		          varLabel := slotDescriptor at: #varLabel.
		          valueLabel := slotDescriptor at: #valueLabel.
		          valueBox := slotDescriptor at: #valueBox.

		          valueBox extent: extent.

		          valueShape := valueLabel ifNil: [ valueBox ] ifNotNil: [ 
			                        RSLocation new
				                        inner;
				                        stick: valueLabel on: valueBox.
			                        RSComposite new
				                        model: value asString -> value;
				                        shapes:
					                        (Array with: valueBox with: valueLabel);
				                        adjustToChildren;
				                        yourself ].

		          RSLocation new
			          left;
			          outer;
			          offset: -2 @ 0;
			          move: varLabel on: valueShape.

		          slotShape := RSComposite new
			                       model:
				                       (slotDescriptor at: #var)
				                       -> valueShape model;
			                       shapes:
				                       (Array with: varLabel with: valueShape);
			                       yourself ].

	RSVerticalLineLayout new
		verticalGap: 0;
		on: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: 2;
		                  yourself.

	^ RSGroup new
		  add: compositeShape;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupKnownReferences: aSet recursiveReferences: refs [

	^ RSGroup new
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupRecursiveKnownReferences: aSet layoutBlock: aBlock [

	"This message is a delegate that allows the sender to not pass 
    recursive references and use the ones known to the receiver."

	^ self
		  asSlotsGroupKnownReferences: aSet
		  recursiveReferences: self recursiveReferences
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 30 title: 'Slots graph'>
	| canvas |
	canvas := self
		          onCanvas: RSCanvas new @ RSCanvasController
		          drawSlotsGraphOfRecursiveReferences:
		          self recursiveReferences.
	^ canvas inspectorCanvas
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Kernel-Visualizations' }
Object >> instVarsNamesOrderedCollection [

	^ self class allInstVarNames collect: [ :varName | 
		  varName -> [ :anObj | anObj instVarNamed: varName ] ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> lineShape [

	| controller |
	controller := RSStartEndCPAPController new
		              controller: RSDirectedBezierCPAPController new;
		              startAttachPoint: RSCenteredAttachPoint new;
		              endAttachPoint: RSBorderAttachPoint new;
		              yourself.
	^ RSBezier new
		  "cornerRadii: 2;"
		  "markerEnd: RSArrowedLine new defaultHead asMarker;"
		  controlPointsController: controller;
		  yourself
	"		  border: (RSBorder new color: Color gray lighter lighter);"
]

{ #category : #'*Kernel-Visualizations' }
Object >> onCanvas: aCanvas drawSlotsGraphOfRecursiveReferences: f [

	| fromShapes toShapes shapesAssociations layoutAssociations edges eb |
	fromShapes := OrderedCollection new.
	toShapes := IdentityDictionary new.
	self
		slotsMap: self instVarsNamesOrderedCollection
		fromShapes: fromShapes
		toShapes: toShapes
		depth: 0.

	aCanvas addAll: toShapes values.

	layoutAssociations := OrderedCollection new.
	shapesAssociations := OrderedCollection new.

	fromShapes do: [ :anAssociation | 
		| boxShape boxParentShape toShape |
		boxShape := anAssociation key.
		boxParentShape := anAssociation value.
		toShape := toShapes at: boxShape model.
		layoutAssociations add: boxParentShape -> toShape.
		shapesAssociations add: boxShape -> toShape ].

	"This will add edges directly to the canvas."
	(RSLineBuilder new: self lineShape)
		canvas: aCanvas;
		useElementAssociations: shapesAssociations.

	"aCanvas edges translucent."

	eb := RSLineBuilder line.
	edges := layoutAssociations collect: [ :anAssociation | 
		         eb edgeFrom: anAssociation key to: anAssociation value ].

	RSHorizontalTreeLayout on: aCanvas nodes edges: edges.

	^ aCanvas
]

{ #category : #'*Kernel-Visualizations' }
Object >> onGroup: aGroup fromShapes: fromShapes toShapes: toShapes slotRendererMap: aDictionary [

	| aSet |
	^ self instVarsNamesOrderedCollection
		  ifEmpty: [ 
			  | model |
			  model := self isImmediateObject
				           ifTrue: [ Object new ]
				           ifFalse: [ self ].
			  RSLabel new
				  model: model;
				  text: self asString;
				  yourself ]
		  ifNotEmpty: [ :selectors | 
			  | shapes radious descriptors compositeShape extent |
			  "Basic settings for rounding the boxes"
			  radious := 2.

			  extent := RSLabel new
				            model: nil;
				            extent.

			  descriptors := selectors collect: [ :anAssociation | 
				                 | value valueLabel varLabel valueBox var accessor model |
				                 var := anAssociation key.
				                 accessor := anAssociation value.
				                 value := accessor value: self.

				                 aDictionary at: var ifAbsent: [ 
					                 self
						                 onGroup: aGroup
						                 fromShapes: fromShapes
						                 toShapes: toShapes
						                 slotRendererMap: aDictionary ].

				                 model := (aSet includes: value) ifFalse: [ value ].
				                 valueLabel := (aSet includes: value)
					                               ifTrue: [ nil ]
					                               ifFalse: [ 
						                               RSLabel new
							                               model: value asString;
							                               yourself: [ :labelShape | 
								                               extent := extent max:
										                                         labelShape extent ] ].

				                 varLabel := RSLabel new
					                             model: var;
					                             yourself.
				                 varLabel color: varLabel color lighter lighter.

				                 valueBox := RSBox new
					                             model: value;
					                             color: Color white;
					                             cornerRadius: 2;
					                             withBorder;
					                             yourself.

				                 "Our descriptor is a plain dictionary."
				                 Dictionary new
					                 at: #var put: var;
					                 at: #value put: value;
					                 at: #valueLabel put: valueLabel;
					                 at: #varLabel put: varLabel;
					                 at: #valueBox put: valueBox;
					                 yourself ].

			  extent := extent x * 3 / 2 @ extent y.

			  shapes := descriptors collect: [ :slotDescriptor | 
				            | varLabel valueBox valueLabel value valueShape slotShape |
				            "Unpacking."
				            value := slotDescriptor at: #value.
				            varLabel := slotDescriptor at: #varLabel.
				            valueLabel := slotDescriptor at: #valueLabel.
				            valueBox := slotDescriptor at: #valueBox.

				            valueBox extent: extent.

				            valueShape := valueLabel
					                          ifNil: [ valueBox ]
					                          ifNotNil: [ 
						                          RSLocation new
							                          inner;
							                          stick: valueLabel on: valueBox.
						                          RSComposite new
							                          model: value asString -> value;
							                          shapes:
								                          (Array
									                           with: valueBox
									                           with: valueLabel);
							                          adjustToChildren;
							                          yourself ].

				            RSLocation new
					            left;
					            outer;
					            offset: -2 @ 0;
					            move: varLabel on: valueShape.

				            slotShape := RSComposite new
					                         model:
						                         (slotDescriptor at: #var)
						                         -> valueShape model;
					                         shapes:
						                         (Array with: varLabel with: valueShape);
					                         yourself ].

			  RSVerticalLineLayout new
				  verticalGap: 0;
				  on: shapes.

			  RSAlignment new
				  shapes: shapes;
				  right.

			  compositeShape := RSComposite new
				                    shapes: shapes;
				                    padding: 2;
				                    yourself.

			  RSGroup new
				  add: compositeShape;
				  yourself ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> recursiveReferences [

	^ #(  )
]

{ #category : #'*Kernel-Visualizations' }
Object >> slotsMap: selectors fromShapes: fromShapes toShapes: toShapes depth: level [

	| shapes radius descriptors compositeShape extent classLabel boxedCompositeShape nilLabel metaColor depthLabel metaFontSize mineShape |
	"Basic settings for rounding the boxes"
	radius := Float e.

	mineShape := RSComposite new
		             model: self;
		             addInteraction: RSDraggable new;
		             "addInteraction: RSHighlightable withLines;"yourself.

	toShapes at: self put: mineShape.

	nilLabel := RSLabel new
		            model: nil;
		            yourself.
	metaColor := nilLabel color lighter lighter lighter.
	metaFontSize := nilLabel fontSize * (Float goldenRatio - 1).
	extent := nilLabel extent.

	classLabel := RSLabel new
		              model: self class;
		              fontSize: metaFontSize;
		              color: metaColor;
		              italic;
		              yourself.

	depthLabel := RSLabel new
		              model: level;
		              fontSize: metaFontSize;
		              color: metaColor;
		              italic;
		              yourself.

	descriptors := selectors collect: [ :anAssociation | 
		               | value valueLabel varLabel valueBox var accessor |
		               var := anAssociation key.
		               accessor := anAssociation value.
		               value := accessor value: self.

		               valueLabel := (value isImmediateObject or: [ 
			                              value isNil or: [ value isBoolean ] ])
			                             ifTrue: [ 
				                             RSLabel new
					                             text: value asString;
					                             yourself: [ :labelShape | 
						                             extent := extent max:
								                                       labelShape extent ] ]
			                             ifFalse: [ 
				                             (toShapes includesKey: value) 
					                             ifFalse: [ 
						                             | map |
						                             map := value
							                                    instVarsNamesOrderedCollection.
						                             value
							                             slotsMap: map
							                             fromShapes: fromShapes
							                             toShapes: toShapes
							                             depth: level + 1 ].
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
				                        fromShapes add: valueBox -> mineShape.
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
		label := RSLabel new
			         model: self;
			         yourself: [ :l | 
				         l extent:
						         (l extent max: classLabel extent + depthLabel extent) ].
		shapes := Array with: label ].

	compositeShape := RSComposite new
		                  shapes: shapes;
		                  padding: radius;
		                  yourself.

	boxedCompositeShape := RSBox new
		                       color: Color white;
		                       extent: compositeShape extent;
		                       cornerRadius: radius;
		                       withBorder;
		                       borderDo: [ :border | 
			                       level = 0
				                       ifTrue: [ 
					                       border width: border width double ]
				                       ifFalse: [ border color: metaColor ] ];
		                       yourself.

	RSLocation new
		inner;
		stick: compositeShape on: boxedCompositeShape.

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

	RSLocation new
		above;
		stick: depthLabel on: boxedCompositeShape.

	RSAlignment new
		shapes: { 
				boxedCompositeShape.
				depthLabel };
		right.

	mineShape
		shapes: { 
				classLabel.
				depthLabel.
				boxedCompositeShape };
		adjustToChildren;
		padding: radius
]
