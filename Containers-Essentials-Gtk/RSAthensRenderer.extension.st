Extension { #name : #RSAthensRenderer }

{ #category : #'*Containers-Essentials-Gtk' }
RSAthensRenderer >> visitPangoText: aPangoShape [

	aPangoShape hasText ifFalse: [ ^ self ].

	aPangoShape updateBaseRectangleOnCairoCanvas: athensCanvas.

	self visitShapeIfNecessary: aPangoShape block: [  ]
]
