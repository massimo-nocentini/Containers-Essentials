Extension { #name : 'RSGroup' }

{ #category : '*Containers-Essentials-Visualizations' }
RSGroup >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitRSGroup: self
]
