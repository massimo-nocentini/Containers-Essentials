Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> instVarsNamesOrderedCollection [

	^ { 
		  #methodClass.
		  #selector.
		  (#formattedCode -> [ :anObj | anObj sourceNode formattedCode ]) }
]
