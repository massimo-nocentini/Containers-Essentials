Extension { #name : #RSParametricLine }

{ #category : #'*Containers-Essentials-Visualizations' }
RSParametricLine >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRSParametricLine: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSParametricLine >> asShapeParamDistanceScatter [

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    x: param y: cumulativeArcLengths;
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new asFloat;
			   build;
			   shapes)
]
