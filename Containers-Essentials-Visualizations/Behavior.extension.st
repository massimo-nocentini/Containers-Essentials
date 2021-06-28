Extension { #name : #Behavior }

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> instVarsNamesOrderedCollection [

	^ { 
		  #name asSlotDescriptor inline.
		  #class asSlotDescriptor.
		  #superclass asSlotDescriptor.
		  #typeOfClass asSlotDescriptor.
		  #instanceCount asSlotDescriptor.
		  #spaceUsed asSlotDescriptor.
		  #kindAsSymbol asSlotDescriptor }
]
