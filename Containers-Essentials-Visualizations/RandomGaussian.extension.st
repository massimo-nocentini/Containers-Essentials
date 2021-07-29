Extension { #name : #RandomGaussian }

{ #category : #'*Containers-Essentials-Visualizations' }
RandomGaussian >> asShapeScatter [

	| gaussian points |
	gaussian := self copy.
	points := (1 to: 500) collect: [ :each1 | gaussian next ].

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    y: points;
					    yourself: [ :plot | plot color: Color gray translucent ]);
			   addDecoration: RSHorizontalTick new integer;
			   addDecoration: RSVerticalTick new integer;
			   build;
			   shapes)
]
