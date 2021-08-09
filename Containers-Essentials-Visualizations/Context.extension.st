Extension { #name : #Context }

{ #category : #'*Containers-Essentials-Visualizations' }
Context >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitContext: self
]
