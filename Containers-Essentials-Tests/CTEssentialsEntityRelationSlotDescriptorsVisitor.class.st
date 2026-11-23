"
I am a visitor that describes the slots of a `CTEssentialsTestEntity`, its name and its relation, and of a `CTEssentialsTestRelation`, its subject, name and object, with no header and the names inline.
"
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
