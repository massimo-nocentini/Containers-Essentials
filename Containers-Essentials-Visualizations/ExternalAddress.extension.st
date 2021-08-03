Extension { #name : #ExternalAddress }

{ #category : #'*Containers-Essentials-Visualizations' }
ExternalAddress >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitExternalAddress: self
]
