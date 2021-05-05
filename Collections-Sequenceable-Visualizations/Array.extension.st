Extension { #name : #Array }

{ #category : #'*Collections-Sequenceable-Visualizations' }
Array >> instVarsNamesOrderedCollection [

	^ self withIndexCollect: [ :each :index | 
		  index asString asSymbol -> [ :anObj | each ] ]
]
