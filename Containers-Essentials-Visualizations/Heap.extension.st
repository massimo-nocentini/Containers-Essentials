Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Visualizations' }
Heap >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { (#asShapeValueTree asSlotDescriptor
		   @ [ :anObj | anObj asShapeValueTree ]) quote }
]