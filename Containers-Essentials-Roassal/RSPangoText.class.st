"
I am a shape that represent a rich text and visualizes it via Pango.
"
Class {
	#name : #RSPangoText,
	#superclass : #RSBoundingShape,
	#instVars : [
		'markup',
		'fontDescription'
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

{ #category : #initialization }
RSPangoText >> initialize [

	super initialize.

	fontDescription := PangoFontDescription new
]

{ #category : #accessing }
RSPangoText >> markup [

	^ markup
]

{ #category : #accessing }
RSPangoText >> markup: anObject [

	markup := anObject.

	self updateBaseRectangle
]

{ #category : #accessing }
RSPangoText >> updateBaseRectangle [

	| surface |
	surface := AthensCairoSurface width: 1 height: 1.

	surface drawDuring: [ :canvas |
		| pangoLayout extent |
		pangoLayout := PangoLayout newCanvas: canvas.
		pangoLayout
			fontDescription: fontDescription;
			markup: self markup.

		extent := pangoLayout scaledSize.

		baseRectangle := Rectangle floatCenter: 0.0 asPoint extent: extent ]
]
