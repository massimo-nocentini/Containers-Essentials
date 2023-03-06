"
I am a shape that represent a rich text and visualizes it via Pango.
"
Class {
	#name : #RSPangoText,
	#superclass : #RSBoundingShape,
	#instVars : [
		'markup',
		'fontDescription',
		'baseline'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #visiting }
RSPangoText >> accept: aVisitor [

	^ aVisitor visitPangoText: self
]

{ #category : #accessing }
RSPangoText >> fontDescription [

	^ fontDescription
]

{ #category : #accessing }
RSPangoText >> fontDescription: anObject [

	fontDescription := anObject.

	self updateBaseRectangle
]

{ #category : #testing }
RSPangoText >> hasText [

	^ markup ifNil: [ false ] ifNotNil: [ markup isNotEmpty ]
]

{ #category : #initialization }
RSPangoText >> initPangoLayout: aPangoLayout [

	aPangoLayout fontDescription: self fontDescription.
	aPangoLayout markup: (self markup ifNil: [ '' ])
]

{ #category : #initialization }
RSPangoText >> initialize [

	| font |
	super initialize.

	baseline := 0.0 asPoint.

	font := StandardFonts defaultFont.

	self fontDescription: (PangoFontDescription newFromString:
			 font familyName , ' ' , font pointSize asString)
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

		self initPangoLayout: pangoLayout.

		canvas updateLayout: pangoLayout.

		self markup ifNil: [
			baseline := pangoLayout size  ].

		extent := (pangoLayout size - baseline - (0 @ pangoLayout baseline / 2)) pangoUnscaled.

		baseRectangle := Rectangle floatCenter: 0.0 asPoint extent: extent ]
]
