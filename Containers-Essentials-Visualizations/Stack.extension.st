Extension { #name : #Stack }

{ #category : #'*Containers-Essentials-Visualizations' }
Stack >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitStack: self
]
