"
I am a camera setter that shows all the shapes of the canvas with a `padding`, a number or a point, which I add to their extent: half of it is on each side, as the camera looks at their center. `RSRoassalExporter>>#zoomToShapesWithPadding:` gives me to an exporter.
"
Class {
	#name : 'RSZoomToShapesSetterWithPadding',
	#superclass : 'RSZoomToShapesSetter',
	#instVars : [
		'padding'
	],
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'initialization' }
RSZoomToShapesSetterWithPadding >> extent [

	^ super extent + padding asPoint
]

{ #category : 'initialization' }
RSZoomToShapesSetterWithPadding >> padding: aPoint [

	padding := aPoint
]
