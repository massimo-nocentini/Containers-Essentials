Extension { #name : #GreatestCommonDivisor }

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> instVarsNamesOrderedCollection [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  (#coprime asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeDividendOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeDivisorOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  #equations asSlotDescriptor instVarNameHasBeenGiven.
		  #divisibility asSlotDescriptor }
]
