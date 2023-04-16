Class {
	#name : #RSZoomToShapesSetterWithPadding,
	#superclass : #RSZoomToShapesSetter,
	#instVars : [
		'padding'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #initialization }
RSZoomToShapesSetterWithPadding >> extent [

	^ super extent + padding asPoint
]

{ #category : #initialization }
RSZoomToShapesSetterWithPadding >> padding: aPoint [

	padding := aPoint
]

{ #category : #initialization }
RSZoomToShapesSetterWithPadding >> setCamera [

	| rect |
	rect := canvas encompassingRectangle.
	canvas camera
		position: rect floatCenter negated;
		scale: 1
]
