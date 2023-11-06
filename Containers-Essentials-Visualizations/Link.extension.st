Extension { #name : 'Link' }

{ #category : '*Containers-Essentials-Visualizations' }
Link >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitLink: self
]
