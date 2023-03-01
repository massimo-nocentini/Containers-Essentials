"
I am a shape that represent a rich text and visualizes it via Pango.
"
Class {
	#name : #RSPangoText,
	#superclass : #RSBoundingShape,
	#instVars : [
		'markup'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #visiting }
RSPangoText >> accept: aVisitor [

	^ aVisitor visitPangoText: self
]

{ #category : #testing }
RSPangoText >> hasText [

	^ markup ifNil: [ false ] ifNotNil: [ markup isNotEmpty ]
]

{ #category : #accessing }
RSPangoText >> markup [

	^ markup
]

{ #category : #accessing }
RSPangoText >> markup: anObject [

	markup := anObject
]
