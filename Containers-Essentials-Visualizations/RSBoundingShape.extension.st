Extension { #name : #RSBoundingShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSBoundingShape >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRSBoundingShape: self
]
