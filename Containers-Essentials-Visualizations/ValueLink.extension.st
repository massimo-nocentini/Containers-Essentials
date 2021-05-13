Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials-Visualizations' }
ValueLink >> instVarsNamesOrderedCollection [

	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ { #value } , super instVarsNamesOrderedCollection
]
