Extension { #name : 'Duration' }

{ #category : '*Containers-Essentials-Visualizations' }
Duration >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitDuration: self
]
