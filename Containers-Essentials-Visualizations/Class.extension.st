Extension { #name : #Class }

{ #category : #'*Containers-Essentials-Visualizations' }
Class >> instVarsNamesOrderedCollection_testMagnitudeSubclassesSlotsGraph [

	^ { 
		  #name asSlotDescriptor.
		  "(#comment asSlotDescriptor inline: true)."
		  (#instVarNames asSlotDescriptor
			   inline: true;
			   noHeader;
			   in: [ :aDescriptor | 
				   aDescriptor quote: [ :anArray | 
						   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ] ]).
		  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
			   self subclasses ifEmpty: [ aDescriptor inline: true ] ]) }
]
