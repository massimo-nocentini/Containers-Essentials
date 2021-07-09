Extension { #name : #GreatestCommonDivisor }

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDividendOverGCD [

	^ (self a /% self value) asShapeSlotsDfsTree
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> asShapeDivisorOverGCD [

	^ (self b /% self value) asShapeSlotsDfsTree
]

{ #category : #'*Containers-Essentials-Visualizations' }
GreatestCommonDivisor >> instVarsNamesOrderedCollection [

	^ { 
		  #a asSlotDescriptor.
		  #b asSlotDescriptor.
		  #value asSlotDescriptor.
		  (#asString asSlotDescriptor inline: true).
		  (#asShapeDividendOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeDivisorOverGCD asSlotDescriptor
			   inline: true;
			   quote).
		  #equations asSlotDescriptor instVarNameHasBeenGiven.
		  #divisibility asSlotDescriptor }
]
