Extension { #name : #SequenceableCollection }

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesTree [

	<inspectorPresentationOrder: 100 title: 'Boxes'>
	| shapes aCanvas maxPoint |
	maxPoint := 0 @ 0.
	shapes := self collect: [ :each | 
		          RSBox new
			          model: each;
			          addInteraction: RSPopup new;
			          size: (each ifNil: [ 0 ]);
			          yourself ].


	RSFlowLayout new
		alignMiddle;
		gapSize: 1;
		applyOn: shapes.

	aCanvas := RSCanvas new @ RSCanvasController.

	^ aCanvas
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesTreeContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasGrid [

	<inspectorPresentationOrder: 200 title: 'Grid'>
	| shapes aCanvas maxPoint |
	maxPoint := 0 @ 0.
	shapes := self withIndexCollect: [ :each :i | 
		          | value index shape |
		          value := RSLabel new
			                   model: each;
			                   yourself.
		          index := RSLabel new
			                   model: i;
			                   text: '(' , i asString , ')';
			                   fontSize: value fontSize >> 1;
			                   yourself.
		          RSLocation new bottom right
			          offset: index textWidth @ (index textHeight / 2);
			          move: index on: value.
		          shape := RSComposite new
			                   model: i -> each;
			                   addShape: value;
			                   addShape: index;
			                   adjustToChildren;
			                   padding: 2;
			                   " border: (RSBorder new
					                    color: (Color gray alpha: 0.3);
					                    yourself);"
			                   border: (RSBorder new
					                    color:
						                    Color gray lighter lighter lighter lighter;
					                    yourself);
			                   yourself.

		          maxPoint := maxPoint max: shape extent.
		          shape ].

	maxPoint := maxPoint + 1 asPoint.
	shapes do: [ :each | each extent: maxPoint ].

	RSGridLayout
		on: shapes
		withGap: 0
		withLineItemsCount: self size sqrtFloor.

	aCanvas := RSCanvas new @ RSCanvasController.

	^ aCanvas
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasGridContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasOddEvenBipartedBoxes [

	<inspectorPresentationOrder: 300 title: 'Parity biparted boxes'>
	| shapes aCanvas maxPoint |
	maxPoint := 0 @ 0.
	shapes := self withIndexCollect: [ :each :i | 
		          | value index shape |
		          value := RSLabel new
			                   model: each;
			                   yourself.
		          index := RSLabel new
			                   model: i;
			                   text: '(' , i asString , ')';
			                   fontSize: value fontSize >> 1;
			                   yourself.
		          RSLocation new bottom right
			          offset: index textWidth @ (index textHeight / 2);
			          move: index on: value.
		          shape := RSComposite new
			                   model: i -> each;
			                   addShape: value;
			                   addShape: index;
			                   adjustToChildren;
			                   padding: 2;
			                   " border: (RSBorder new
					                    color: (Color gray alpha: 0.3);
					                    yourself);"
			                   border: (RSBorder new
					                    color:
						                    Color gray lighter lighter lighter lighter;
					                    yourself);
			                   yourself.

		          maxPoint := maxPoint max: shape extent.
		          shape ].

	maxPoint := maxPoint + 1 asPoint.
	shapes do: [ :each | each extent: maxPoint ].

	RSGridLayout on: shapes withGap: 0 withLineItemsCount: 2.

	aCanvas := RSCanvas new @ RSCanvasController.

	^ aCanvas
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Collections-Abstract-Visualizations' }
SequenceableCollection >> inspectorCanvasOddEvenBipartedBoxesContext: aContext [

	aContext withoutEvaluator
]
