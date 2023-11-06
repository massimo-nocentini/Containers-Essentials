Extension { #name : 'FileReference' }

{ #category : '*Containers-Essentials-Visualizations' }
FileReference >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitFileReference: self
]
