Extension { #name : #ExternalAddress }

{ #category : #'*Kernel-Extensions' }
ExternalAddress >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection
	  , { ('Address' -> [ :anAddress | anAddress printString ]) }
]
