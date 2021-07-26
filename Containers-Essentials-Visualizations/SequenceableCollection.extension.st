Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> asShapeFordCircles [

	| r c ratio |
	c := Float goldenRatio double.
	r := (self detectMin: [ :each | each fordRadius ]) fordRadius.
	ratio := c / r.

	^ RSComposite new
		  model: self;
		  shapes: (self collect: [ :each | 
					   | radius |
					   radius := each fordRadius * ratio.
					   RSCircle new
						   model: each;
						   withBorder;
						   color: Color white;
						   position: each * ratio @ radius negated;
						   radius: radius;
						   yourself ]);
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesFlow [

	<inspectorPresentationOrder: 200 title: 'Boxes'>
	| shapes |
	shapes := self asArray collect: [ :each | 
		          | boxShape |
		          boxShape := RSBox new
			                      model: each;
			                      addInteraction: RSPopup new;
			                      yourself.

		          self onBox: boxShape setSizeFrom: each ].

	RSFlowLayout new
		gapSize: 1;
		applyOn: shapes.

	^ RSCanvas new
		  addInteraction: RSCanvasController new;
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasBoxesFlowContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasEnumeration [

	<inspectorPresentationOrder: 300 title: 'Enumeration'>
	| shapes location extent boxes |
	boxes := OrderedCollection new.
	extent := 0 asPoint.
	location := RSLocation new left outer offset: -5 @ 0.
	shapes := self asArray withIndexCollect: [ :each :index | 
		          | boxShape indexShape valueShape |
		          valueShape := RSLabel new model: each.
		          indexShape := RSLabel new
			                        model: index;
			                        fontSize: valueShape fontSize double / 3;
			                        color: Color gray lighter lighter;
			                        yourself.

		          boxShape := RSComposite new
			                      add: valueShape;
			                      padding: 2 @ 0;
			                      yourself.

		          extent := extent max: boxShape extent.
		          boxes add: boxShape.

		          location stick: indexShape on: boxShape.

		          RSComposite new
			          add: indexShape;
			          add: boxShape;
			          yourself ].

	boxes do: [ :each | each extent: extent ].

	RSVerticalLineLayout new
		verticalGap: 5;
		applyOn: shapes.

	RSAlignment new
		shapes: shapes;
		right.

	^ RSCanvas new
		  addInteraction: RSCanvasController new;
		  addAll: shapes;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasEnumerationContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasGrid [

	<inspectorPresentationOrder: 100 title: 'Grid'>
	^ (self asArray
		   onCanvas: RSCanvas new @ RSCanvasController
		   drawGridWithLineItemsCount: self size sqrtFloor) inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasGridContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasIndexParityBipartedGrid [

	<inspectorPresentationOrder: 300 title: 'Index-parity biparted grid'>
	^ (self asArray
		   onCanvas: RSCanvas new @ RSCanvasController
		   drawGridWithLineItemsCount: 2) inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> inspectorCanvasIndexParityBipartedGridContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> onBox: boxShape setSizeFrom: anObject [

	[ boxShape size: (anObject ifNil: [ 0 ]) sqrt ]
		onDNU: #sqrt
		do: [ :anError | boxShape size: 0 ].
	^ boxShape
]

{ #category : #'*Containers-Essentials-Visualizations' }
SequenceableCollection >> onCanvas: aCanvas drawGridWithLineItemsCount: anInteger [

	| shapes maxPoint |
	maxPoint := 0 @ 0.
	shapes := self withIndexCollect: [ :each :i | 
		          | valueShape indexShape |
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

		          RSComposite new
			          model: i -> each;
			          addShape: valueShape;
			          addShape: indexShape;
			          adjustToChildren;
			          padding: 2;
			          border: (RSBorder new
					           color: Color gray lighter lighter lighter lighter;
					           yourself);
			          yourself: [ :shape | 
			          maxPoint := maxPoint max: shape extent ] ].

	maxPoint := maxPoint + 1 asPoint.
	shapes do: [ :each | each extent: maxPoint ].

	RSGridLayout on: shapes withGap: 0 withLineItemsCount: anInteger.

	^ aCanvas
		  addAll: shapes;
		  yourself
]
