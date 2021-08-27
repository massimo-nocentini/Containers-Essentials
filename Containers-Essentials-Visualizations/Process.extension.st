Extension { #name : #Process }

{ #category : #'*Containers-Essentials-Visualizations' }
Process >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitProcess: self
]
