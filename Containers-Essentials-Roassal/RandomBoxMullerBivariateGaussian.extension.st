Extension { #name : 'RandomBoxMullerBivariateGaussian' }

{ #category : '*Containers-Essentials-Roassal' }
RandomBoxMullerBivariateGaussian >> asShapeScatter [

	| gen points |
	gen := self copy.
	points := ((1 to: 500) collect: [ :each1 | gen next ]) sorted.

	^ RSComposite new shapes: (RSCompositeChart new
			   add: (RSScatterPlot new
					    x: (points collect: [ :each | each x ])
					    y: (points collect: [ :each | each y ]);
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new;
			   build;
			   shapes)
]
