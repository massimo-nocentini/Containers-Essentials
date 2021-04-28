Extension { #name : #Object }

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
		               | value valueLabel varLabel valueBox var accessor model |
		               var := anAssociation key.
		               accessor := anAssociation value.
		               value := accessor value: self.

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
	"This message should be overridden by any subclass that has a recursive structure
	 that would be visualized; in particular, the layout block has to be plugged in."

	^ self
		  asSlotsGroupKnownReferences: aSet
		  recursiveReferences: refs
		  layoutBlock: [ :shapes | RSNoLayout on: shapes ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupKnownReferences: aSet recursiveReferences: refs layoutBlock: aBlock [
	^ RSGroup new
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupRecursiveKnownReferences: aSet [
	"This message should be overridden by any subclass that has a recursive structure
	 that would be visualized; in particular, the layout block has to be plugged in."

	^ self
		  asSlotsGroupRecursiveKnownReferences: aSet
		  layoutBlock: [ :shapes | RSNoLayout on: shapes ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsGroupRecursiveKnownReferences: aSet layoutBlock: aBlock [
	"This message is a delegate that allows the sender to not pass 
    recursive references and use the ones known to the receiver."

	^ self
		  asSlotsGroupKnownReferences: aSet
		  recursiveReferences: self recursiveReferences
		  layoutBlock: aBlock
]

{ #category : #'*Kernel-Visualizations' }
Object >> gtInspectorSlotsGraphIn: composite [

	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Slots graph';
		  initializeCanvas: [ 
			  (self gtInspectorSlotsGraphInCanvas: RSCanvas new)
			  @ RSCanvasController ];
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> gtInspectorSlotsGraphInCanvas: aCanvas [

	| aGroup |
	aGroup := self asSlotsGroupKnownReferences: IdentitySet empty.
	^ aCanvas
		  addAll: aGroup;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> gtInspectorSlotsGraphRecursiveIn: composite [

	<gtInspectorPresentationOrder: 30>
	^ self recursiveReferences ifNotEmpty: [ :refs | 
		  composite roassal3
			  title: 'Slots graph (recursive)';
			  initializeCanvas: [ 
				  (self
					   gtInspectorSlotsGraphRecursiveInCanvas: RSCanvas new
					   recursiveReferences: refs) @ RSCanvasController ];
			  yourself ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> gtInspectorSlotsGraphRecursiveInCanvas: aCanvas recursiveReferences: refs [

	| aGroup |
	aGroup := self
		          asSlotsGroupKnownReferences: IdentitySet empty
		          recursiveReferences: refs.
	^ aCanvas
		  addAll: aGroup;
		  yourself
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
Object >> onCanvas: aCanvas drawSlotsGraphOfRecursiveReferences: aCollection [

	| aGroup |
	aGroup := self
		          asSlotsGroupKnownReferences: IdentitySet empty
		          recursiveReferences: aCollection.
	^ aCanvas
		  addAll: aGroup;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> recursiveReferences [

	^ #(  )
]
