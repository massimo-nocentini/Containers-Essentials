Extension { #name : 'BlockClosure' }

{ #category : '*Containers-Essentials-Visualizations' }
BlockClosure >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitBlockClosure: self
]
