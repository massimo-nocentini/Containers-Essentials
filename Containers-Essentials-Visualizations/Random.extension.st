Extension { #name : 'Random' }

{ #category : '*Containers-Essentials-Visualizations' }
Random >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRandom: self
]
