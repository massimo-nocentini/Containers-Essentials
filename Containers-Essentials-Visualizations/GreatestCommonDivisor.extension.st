Extension { #name : #GreatestCommonDivisor }

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> instVarsNamesOrderedCollection [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  #equations asSlotDescriptor instVarNameHasBeenGiven.
		  (#asShapeDividendOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeDivisorOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  #coprime asSlotDescriptor }
]
