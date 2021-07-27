Extension { #name : #BlockClosure }

{ #category : #'*Containers-Essentials-Visualizations' }
BlockClosure >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitBlockClosure: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
BlockClosure >> inlineBlock [

	^ self
]
