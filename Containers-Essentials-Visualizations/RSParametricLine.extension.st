Extension { #name : #RSParametricLine }

{ #category : #'*Containers-Essentials-Visualizations' }
RSParametricLine >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRSParametricLine: self
]
