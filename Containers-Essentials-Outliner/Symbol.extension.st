Extension { #name : #Symbol }

{ #category : #'*Containers-Essentials-Outliner' }
Symbol >> asDefaultShapeForWalker: aWalker [

	^ aWalker shapeBuilder multilineLabel: self storeString model: self
]
