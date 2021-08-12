Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Inspector' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]
