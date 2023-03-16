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
	#category : #'Containers-Essentials-Gtk'
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

	(AthensCairoSurface width: 1 height: 1) drawDuring: [
		:athensCairoCanvas |
		self updateBaseRectangleOnAthensCairoCanvas: athensCairoCanvas ]
]

{ #category : #accessing }
RSPangoText >> updateBaseRectangleOnAthensCairoCanvas: cairo_t [

	| pangoLayout |
	pangoLayout := PangoLayout newCanvas: cairo_t.

	self initPangoLayout: pangoLayout.

	cairo_t updateLayout: pangoLayout.

	self extent: pangoLayout logicalRectangle extent
]
