Extension { #name : #FileReference }

{ #category : #'*Containers-Essentials-Visualizations' }
FileReference >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , #( fullName contents
	     size )
]
