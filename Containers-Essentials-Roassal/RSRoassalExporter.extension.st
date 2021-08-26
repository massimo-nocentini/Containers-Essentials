Extension { #name : #RSRoassalExporter }

{ #category : #'*Containers-Essentials-Roassal' }
RSRoassalExporter >> zoomToShapesWithPadding: aPadding [

	self cameraSetter: (RSZoomToShapesSetterWithPadding new
			 padding: aPadding;
			 yourself)
]
