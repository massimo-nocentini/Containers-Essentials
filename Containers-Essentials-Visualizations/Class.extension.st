Extension { #name : 'Class' }

{ #category : '*Containers-Essentials-Visualizations' }
Class >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitClass: self
]
