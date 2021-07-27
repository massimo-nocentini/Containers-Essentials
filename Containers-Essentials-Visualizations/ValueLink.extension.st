Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials-Visualizations' }
ValueLink >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitValueLink: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
ValueLink >> instVarsNamesOrderedCollectionNested [

	^ { #value asSlotDescriptor }
	  , super instVarsNamesOrderedCollectionNested
]
