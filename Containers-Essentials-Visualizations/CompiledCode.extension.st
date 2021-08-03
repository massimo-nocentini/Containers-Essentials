Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCompiledMethod: self
]
