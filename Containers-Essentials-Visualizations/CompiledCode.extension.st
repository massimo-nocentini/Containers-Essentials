Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> instVarsNamesOrderedCollection [

	^ { ('formatted' -> [ :anObj | anObj sourceNode formattedCode ]) }
]
