Extension { #name : #RSParameterization }

{ #category : #'*Containers-Essentials-Roassal' }
RSParameterization >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRSParameterization: self
]
