Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitFraction: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> asShapeFordCircles [

	| r c reduced floor ratio |
	floor := self floor.
	reduced := self asFractionWrtFloor.
	c := Float goldenRatio double.
	r := reduced fordRadius.
	ratio := c / r.

	^ RSComposite new
		  model: self;
		  shapes: (self kissingFractions collect: [ :each | 
					   | radius |
					   radius := each fordRadius * ratio.
					   RSCircle new
						   model: each + floor;
						   withBorder;
						   color: Color white;
						   position: each * ratio @ radius negated;
						   radius: radius;
						   yourself: [ :circle | 
							   each = reduced ifTrue: [ circle sameColorAsBorderColor ] ] ]);
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> asShapeOnUnitCircle [

	| circle point puc scale origin |
	puc := self asPointOnUnitCircle.

	scale := NSScale linear
		         domain: { 0. 1 };
		         range: { 
				         0.
				         (20 * Float goldenRatio) } yourself.

	origin := RSCircle new
		          radius: Float goldenRatio / 2;
		          withBorder;
		          color: Color white;
		          position: 0 asPoint;
		          yourself.

	circle := RSCircle new
		          radius: (scale scale: 1);
		          withBorder;
		          color: Color white;
		          position: 0 asPoint;
		          yourself.

	point := RSCircle new
		         model: puc;
		         radius: Float goldenRatio;
		         withBorder;
		         sameColorAsBorderColor;
		         position: (scale scale: puc);
		         yourself.

	^ RSComposite new
		  model: puc;
		  shapes: (Array with: circle with: origin with: point);
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> inspectorCanvasFordCircles [

	<inspectorPresentationOrder: 20 title: 'Ford circles'>
	^ RSCanvas new
		  add: self asShapeFordCircles;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> inspectorCanvasFordCirclesContext: aContext [

	aContext withoutEvaluator
]
