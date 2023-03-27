Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	^ aWalker shapeBuilder
		  multilineLabel: self fullPrintString
		  model: self
]
