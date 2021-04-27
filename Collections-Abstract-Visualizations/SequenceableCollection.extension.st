Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesTree [

	<inspectorPresentationOrder: 200 title: 'Boxes'>
	| shapes |
	shapes := self asArray collect: [ :each | 
		          | boxShape |
		          boxShape := RSBox new
			                      model: each;
			                      addInteraction: RSPopup new;
			                      yourself.

		          [ boxShape size: (each ifNil: [ 0 ]) ]
			          onDNU: #asPoint
			          do: [ :e | boxShape size: 0 ] ].

	RSFlowLayout new
		gapSize: 1;
		applyOn: shapes.

	^ RSCanvas new
		  addInteraction: RSCanvasController new;
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesTreeContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasGrid [

	<inspectorPresentationOrder: 100 title: 'Grid'>
	^ (self asArray
		   onCanvas: RSCanvas new @ RSCanvasController
		   drawGridWithLineItemsCount: self size sqrtFloor) inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasGridContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasIndexParityBipartedGrid [

	<inspectorPresentationOrder: 300 title: 'Index-parity biparted grid'>
	^ (self asArray
		   onCanvas: RSCanvas new @ RSCanvasController
		   drawGridWithLineItemsCount: 2) inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasIndexParityBipartedGridContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> onCanvas: aCanvas drawGridWithLineItemsCount: anInteger [

	| shapes maxPoint |
	maxPoint := 0 @ 0.
	shapes := self withIndexCollect: [ :each :i | 
		          | valueShape indexShape shape |
		          valueShape := RSLabel new
			                        model: each;
			                        yourself.
		          indexShape := RSLabel new
			                        model: i;
			                        text: '(' , i asString , ')';
			                        fontSize: valueShape fontSize >> 1;
			                        yourself.

		          RSLocation new bottom right
			          offset: indexShape textWidth + 2 @ 0;
			          move: indexShape on: valueShape.

		          shape := RSComposite new
			                   model: i -> each;
			                   addShape: valueShape;
			                   addShape: indexShape;
			                   adjustToChildren;
			                   padding: 2;
			                   border: (RSBorder new
					                    color:
						                    Color gray lighter lighter lighter lighter;
					                    yourself);
			                   yourself.

		          maxPoint := maxPoint max: shape extent.

		          shape ].

	maxPoint := maxPoint + 1 asPoint.
	shapes do: [ :each | each extent: maxPoint ].

	RSGridLayout on: shapes withGap: 0 withLineItemsCount: anInteger.

	^ aCanvas
		  addAll: shapes;
		  yourself
]
