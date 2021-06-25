Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> instVarsNamesOrderedCollection [

	^ { 
		  #methodClassName.
		  #selector.
		  (#formattedCode -> [ :anObj | anObj sourceNode formattedCode ]) }
]
