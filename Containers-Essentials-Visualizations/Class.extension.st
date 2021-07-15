Extension { #name : #Class }

{ #category : #'*Containers-Essentials-Visualizations' }
Class >> instVarsNamesOrderedCollection_testMagnitudeSubclassesSlotsGraph [

	^ { 
		  #name asSlotDescriptor.
		  "(#comment asSlotDescriptor inline: true)."
		  (#instVarNames asSlotDescriptor
			   inline: true;
			   quote: #asShapeSlotsDfsTree).
		  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
			   self subclasses ifEmpty: [ aDescriptor inline: true ] ]) }
]
