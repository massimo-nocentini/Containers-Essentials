Extension { #name : #Duration }

{ #category : #'*Containers-Essentials-Visualizations' }
Duration >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  ('Local repr' -> [ :anObj | anObj asString ]).
		  ('Human repr' -> [ :anObj | anObj humanReadablePrintString ]) }
]
