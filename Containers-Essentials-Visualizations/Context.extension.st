Extension { #name : #Context }

{ #category : #'*Containers-Essentials-Visualizations' }
Context >> instVarsNamesOrderedCollection [

	^ { 
		  #home asSlotDescriptor.
		  #sender asSlotDescriptor.
		  #receiver asSlotDescriptor.
		  #selector asSlotDescriptor.
		  "(#arguments asSlotDescriptor inline: true)."
		  #pc asSlotDescriptor.
		  #stackPtr asSlotDescriptor
		  "#receiver asSlotDescriptor instVarNameHasBeenGiven " }
]
