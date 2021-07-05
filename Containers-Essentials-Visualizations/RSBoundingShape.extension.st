Extension { #name : #RSBoundingShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSBoundingShape >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { #asShapeQuoted asSlotDescriptor quote }
]
