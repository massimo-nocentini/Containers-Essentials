Extension { #name : #ExternalAddress }

{ #category : #'*Containers-Essentials-Visualizations' }
ExternalAddress >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { ('Address' -> [ :anAddress | anAddress printString ]) }
]
