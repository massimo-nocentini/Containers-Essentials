Class {
	#name : #CTEssentialsEntityRelationSlotDescriptorsVisitor,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #'*Containers-Essentials-Tests' }
CTEssentialsEntityRelationSlotDescriptorsVisitor >> visitCTEssentialsTestEntity: anEntity [

	^ { 
		  ((self newSlotDescriptorSelector: #name)
			   noHeader;
			   inline).
		  (self newSlotDescriptorSelector: #relation) noHeader }
]

{ #category : #'*Containers-Essentials-Tests' }
CTEssentialsEntityRelationSlotDescriptorsVisitor >> visitCTEssentialsTestRelation: aRelation [

	^ { 
		  (self newSlotDescriptorSelector: #subject) noHeader.
		  ((self newSlotDescriptorSelector: #name)
			   noHeader;
			   inline).
		  (self newSlotDescriptorSelector: #object) noHeader }
]
