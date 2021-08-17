Extension { #name : #Bag }

{ #category : #'*Containers-Essentials-Inspector' }
Bag >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitBag: self
]
