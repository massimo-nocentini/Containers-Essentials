Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials-Visualizations' }
ValueLink >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitValueLink: self
]
