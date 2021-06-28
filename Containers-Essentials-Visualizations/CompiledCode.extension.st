Extension { #name : #CompiledCode }

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> formattedCode [

	^ self sourceNode formattedCode
]

{ #category : #'*Containers-Essentials-Visualizations' }
CompiledCode >> instVarsNamesOrderedCollection [

	^ { 
		  #methodClassName asSlotDescriptor.
		  #selector asSlotDescriptor.
		  #formattedCode asSlotDescriptor }
]
