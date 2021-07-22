Extension { #name : #RSRoassalExporter }

{ #category : #'*Containers-Essentials-Visualizations' }
RSRoassalExporter >> zoomToShapesWithPadding: aPadding [

	self cameraSetter: (RSZoomToShapesSetterWithPadding new
			 padding: aPadding;
			 yourself)
]
