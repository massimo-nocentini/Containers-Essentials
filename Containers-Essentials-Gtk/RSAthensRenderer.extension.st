Extension { #name : #RSAthensRenderer }

{ #category : #'*Containers-Essentials-Gtk' }
RSAthensRenderer >> visitPangoText: aPangoShape [

	aPangoShape hasText ifFalse: [ ^ self ].

	self visitShapeIfNecessary: aPangoShape block: [
		| pangoLayout lbtranslation |
		aPangoShape hasText ifFalse: [ ^ self ].

		lbtranslation := (aPangoShape encompassingRectangle extent / 2.0)
			                 negated.

		matrix translateBy: lbtranslation.
		athensCanvas pathTransform loadAffineTransform: matrix.
		athensCanvas setPathMatrix.

		pangoLayout := PangoLayout newCanvas: athensCanvas.

		aPangoShape initPangoLayout: pangoLayout.

		athensCanvas updateLayout: pangoLayout.

		athensCanvas showLayout: pangoLayout.

		athensCanvas pathTransform translateBy: lbtranslation negated.
		athensCanvas setPathMatrix ]
]
