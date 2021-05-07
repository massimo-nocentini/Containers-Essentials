Extension { #name : #Array }

{ #category : #'*Collections-Sequenceable-Visualizations' }
Array >> instVarsNamesOrderedCollection [

	| positions |
	positions := self withIndexCollect: [ :each :index | 
		             index asString asSymbol -> [ :anObj | each ] ].

	^ super instVarsNamesOrderedCollection , positions
]
