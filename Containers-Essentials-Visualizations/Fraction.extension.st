Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitFraction: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> asDefaultShapeForWalker: aWalker [

	^ self asShapeNaturalRepresentation
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
Fraction >> asShapeNaturalRepresentation [

	| numeratorShape denominatorShape dashShape shapes shapeWithMaxWidth random offset vOffset linspace y |
	random := RandomBoxMullerBivariateGaussian new.

	numeratorShape := RSLabel new
		                  model: self numerator;
		                  yourself.

	denominatorShape := RSLabel new
		                    model: self denominator;
		                    yourself.

	shapeWithMaxWidth := numeratorShape width > denominatorShape width
		                     ifTrue: [ numeratorShape ]
		                     ifFalse: [ denominatorShape ].

	offset := (shapeWithMaxWidth width * Float bronzeRatio) halved.

	shapes := RSGroup new
		          add: numeratorShape;
		          add: denominatorShape;
		          yourself.

	vOffset := (Float bronzeRatio
	            * (numeratorShape height + denominatorShape height))
		           halved.

	RSVerticalLineLayout new
		verticalGap: vOffset;
		alignCenter;
		on: shapes.

	linspace := (shapeWithMaxWidth encompassingRectangle left - offset 
	             to:
	             shapeWithMaxWidth encompassingRectangle right + offset) 
		            linspace: 6.

	y := numeratorShape encompassingRectangle bottom + vOffset halved.

	dashShape := RSdeCasteljauLine new
		             samples: 1;
		             controlPoints:
			             (linspace collect: [ :each | each @ y + random next ]);
		             from: shapeWithMaxWidth;
		             to: shapeWithMaxWidth;
		             yourself.

	^ RSComposite new
		  model: self;
		  shapes: shapes , { dashShape };
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

	<inspectorPresentationOrder: 1010 title: 'Ford circles'>
	^ RSCanvas new
		  add: self asShapeFordCircles;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> inspectorCanvasFordCirclesContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> inspectorCanvasRepresentations [

	<inspectorPresentationOrder: 1010 title: 'Representations'>
	| walker shape |
	walker := CTDfsWalker new.

	walker slotDescriptorsVisitor:
		CTSlotDescriptorsVisitorDetails new.

	shape := self asShapeSlotsDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Fraction >> inspectorCanvasRepresentationsContext: aContext [

	aContext withoutEvaluator
]
