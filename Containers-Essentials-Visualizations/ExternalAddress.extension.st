Extension { #name : #ExternalAddress }

{ #category : #'*Containers-Essentials-Visualizations' }
ExternalAddress >> addressString [

	^ self printString
]

{ #category : #'*Containers-Essentials-Visualizations' }
ExternalAddress >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { #addressString asSlotDescriptor inline }
]
