Extension { #name : #Random }

{ #category : #'*Containers-Essentials-Visualizations' }
Random >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRandom: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Random >> asShapeScatter [

	| gen x y |
	gen := self copy.
	x := ((1 to: 500) collect: [ :each1 | gen next ]) sorted.
	y := x collect: [ :each | gen density: each ].

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    x: x y: y;
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new asFloat;
			   build;
			   shapes)
]
