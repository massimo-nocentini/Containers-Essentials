Extension { #name : #RSAthensRenderer }

{ #category : #'*Containers-Essentials-Roassal' }
RSAthensRenderer >> visitPangoText: aPangoShape [

	aPangoShape hasText ifFalse: [ ^ self ].

	self visitShapeIfNecessary: aPangoShape block: [
		| fontLayout fontDescription lbtranslation |
		aPangoShape hasText ifFalse: [ ^ self ].
		
		lbtranslation := (aPangoShape encompassingRectangle extent / 2.0)
			                 negated.

		matrix translateBy: lbtranslation.
		athensCanvas pathTransform loadAffineTransform: matrix.
		athensCanvas setPathMatrix.

		fontDescription := PangoFontDescription new.
		fontLayout := PangoLayout newCanvas: athensCanvas.
		fontLayout fontDescription: fontDescription.
		fontLayout markup: aPangoShape markup.
		fontLayout setAlignment: PangoAlignment PANGO_ALIGN_LEFT.

		athensCanvas updateLayout: fontLayout.

		athensCanvas showLayout: fontLayout.

		athensCanvas pathTransform translateBy: lbtranslation negated.
		athensCanvas setPathMatrix ]
]
