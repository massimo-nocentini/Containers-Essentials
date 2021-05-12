Extension { #name : #Dictionary }

{ #category : #'*Containers-Essentials-Visualizations' }
Dictionary >> instVarsNamesOrderedCollection [

	^ { #asKeysAndValuesView } , super instVarsNamesOrderedCollection
]
