Extension { #name : #RSAthensRenderer }

{ #category : #'*Containers-Essentials-Roassal' }
RSAthensRenderer >> visitPangoText: aPangoShape [

	aPangoShape hasText ifFalse: [ ^ self ].

	self visitShapeIfNecessary: aPangoShape block: [
		| fontLayout lbtranslation |
		aPangoShape hasText ifFalse: [ ^ self ].

		lbtranslation := (aPangoShape encompassingRectangle extent / 2.0)
			                 negated.

		matrix translateBy: lbtranslation.
		athensCanvas pathTransform loadAffineTransform: matrix.
		athensCanvas setPathMatrix.

		fontLayout := PangoLayout newCanvas: athensCanvas.
		fontLayout fontDescription: aPangoShape fontDescription.
		fontLayout markup: aPangoShape markup.
		fontLayout setAlignment: PangoAlignment PANGO_ALIGN_LEFT.

		athensCanvas updateLayout: fontLayout.

		athensCanvas showLayout: fontLayout.

		athensCanvas pathTransform translateBy: lbtranslation negated.
		athensCanvas setPathMatrix ]
]
