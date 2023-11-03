Class {
	#name : 'CTEssentialsEntityRelationSlotDescriptorsVisitor',
	#superclass : 'CTSlotDescriptorsVisitor',
	#category : 'Containers-Essentials-Tests-SUTs',
	#package : 'Containers-Essentials-Tests',
	#tag : 'SUTs'
}

{ #category : 'as yet unclassified' }
CTEssentialsEntityRelationSlotDescriptorsVisitor >> visitCTEssentialsTestEntity: anEntity [

	^ { 
		  ((self newSlotDescriptorSelector: #name)
			   noHeader;
			   inline).
		  (self newSlotDescriptorSelector: #relation) noHeader }
]

{ #category : 'as yet unclassified' }
CTEssentialsEntityRelationSlotDescriptorsVisitor >> visitCTEssentialsTestRelation: aRelation [

	^ { 
		  (self newSlotDescriptorSelector: #subject) noHeader.
		  ((self newSlotDescriptorSelector: #name)
			   noHeader;
			   inline).
		  (self newSlotDescriptorSelector: #object) noHeader }
]
