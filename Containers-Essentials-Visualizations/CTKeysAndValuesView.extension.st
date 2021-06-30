Extension { #name : #CTKeysAndValuesView }

{ #category : #'*Containers-Essentials-Visualizations' }
CTKeysAndValuesView >> instVarsNamesOrderedCollection [

	^ Array streamContents: [ :aStream | 
		  dict keysAndValuesDo: [ :k :v | 
			  aStream nextPut: (k asString asSlotDescriptor
					   blockClosure: [ v ];
					   yourself) ] ]
]
