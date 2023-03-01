Extension { #name : #RSAthensRenderer }

{ #category : #'*Containers-Essentials-Roassal' }
RSAthensRenderer >> visitPangoText: aPangoShape [

	aPangoShape hasText ifFalse: [ ^ self ].

	self visitShapeIfNecessary: aPangoShape block: [
		| fontLayout fontDescription |
		aPangoShape hasText ifFalse: [ ^ self ].

		athensCanvas pathTransform loadAffineTransform: matrix.

		fontDescription := PangoFontDescription new"FromString:
			                   'Helvetica 18'".
		fontLayout := PangoLayout newCanvas: athensCanvas.
		fontLayout fontDescription: fontDescription.
		fontLayout markup: aPangoShape markup.

		athensCanvas updateLayout: fontLayout.

		"athensCanvas paintTransform rotateByDegrees: 45."

		athensCanvas showLayout: fontLayout ]
]
