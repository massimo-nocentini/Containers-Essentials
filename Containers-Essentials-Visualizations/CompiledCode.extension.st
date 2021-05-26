Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> instVarsNamesOrderedCollection [

	^ { (#formattedCode -> [ :anObj | anObj sourceNode formattedCode ]) }
]
