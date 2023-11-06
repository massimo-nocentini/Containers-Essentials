Extension { #name : 'Array' }

{ #category : '*Containers-Essentials-Visualizations' }
Array >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitArray: self
]
