Extension { #name : #PangoLayout }

{ #category : #'*Containers-Essentials' }
PangoLayout >> getExtentsInkRectangle: inkRectangle logicalRectangle: logicalRectangle [
	"https://docs.gtk.org/Pango/method.Layout.get_attributes.html"

	^ self ffiCall:
		  #( void pango_layout_get_extents #( self , PangoRectangle
		        * inkRectangle , PangoRectangle * logicalRectangle ) )
]

{ #category : #'*Containers-Essentials' }
PangoLayout >> logicalRectangle [
	"Answer a Rectangle with the logical bounds.
	See https://docs.gtk.org/Pango/method.GlyphString.extents.html"

	| logicalRectangle |
	logicalRectangle := PangoRectangle externalNew.

	self
		getExtentsInkRectangle: ExternalAddress null
		logicalRectangle: logicalRectangle.

	^ logicalRectangle asRectangle
]
