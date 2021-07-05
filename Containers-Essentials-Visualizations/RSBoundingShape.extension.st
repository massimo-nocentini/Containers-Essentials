Extension { #name : #RSBoundingShape }

{ #category : #'*Containers-Essentials-Visualizations' }
RSBoundingShape >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { (#quotedYourself asSlotDescriptor
			   blockClosure: [ self ];
			   quote) }
]
