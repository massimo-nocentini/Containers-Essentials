Extension { #name : #BlockClosure }

{ #category : #'*Containers-Essentials-Visualizations' }
BlockClosure >> instVarsNamesOrderedCollection [

	| copied |
	copied := self sourceNode allVariables flatCollect: [ :aRBVariable | 
		          | var |
		          var := outerContext lookupVar: aRBVariable name.
		          var
			          ifNil: [ #(  ) ]
			          ifNotNil: [ { (var name -> [ :anObj | var value ]) } ] ].

	^ super instVarsNamesOrderedCollection , copied
]
