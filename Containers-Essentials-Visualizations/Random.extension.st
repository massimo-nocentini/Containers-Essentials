Extension { #name : #Random }

{ #category : #'*Containers-Essentials-Visualizations' }
Random >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRandom: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Random >> asShapeScatter [

	| gen points |
	gen := self copy.
	points := ((1 to: 500) collect: [ :each1 | gen next ]) sorted.

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    x: points y: (points collect: [ :each | each density: gen ]);
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new;
			   build;
			   shapes)
]
