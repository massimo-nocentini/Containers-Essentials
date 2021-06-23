Extension { #name : #Behavior }

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> instVarsNamesOrderedCollection [

	^ { (#name -> [ :anObject | self name asSymbol ]) }
	  , #( class superclass typeOfClass instanceCount spaceUsed )
]
