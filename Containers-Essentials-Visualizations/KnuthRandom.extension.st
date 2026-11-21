Extension { #name : 'KnuthRandom' }

{ #category : '*Containers-Essentials-Visualizations' }
KnuthRandom >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitKnuthRandom: self
]
