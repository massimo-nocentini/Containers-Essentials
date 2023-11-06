Extension { #name : 'Dictionary' }

{ #category : '*Containers-Essentials-Visualizations' }
Dictionary >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitDictionary: self
]
