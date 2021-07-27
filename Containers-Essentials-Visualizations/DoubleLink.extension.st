Extension { #name : #DoubleLink }

{ #category : #'*Containers-Essentials-Visualizations' }
DoubleLink >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitDoubleLink: self
]
