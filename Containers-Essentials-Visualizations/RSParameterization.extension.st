Extension { #name : #RSParameterization }

{ #category : #'*Containers-Essentials-Visualizations' }
RSParameterization >> asShapeParamDistanceScatter [

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    x: domain y: cumulativeArcLengths;
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new asFloat;
			   build;
			   shapes)
]
