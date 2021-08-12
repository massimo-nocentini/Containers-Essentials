Class {
	#name : #SlotDescriptorsVisitorNestedLinks,
	#superclass : #SlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #visiting }
SlotDescriptorsVisitorNestedLinks >> visitLink: aLink [

	^ { (#nextLink asSlotDescriptor
		   blockClosure: [ aLink nextLink asShapeSlotsDfsTree: self ];
		   inline: true;
		   quote) }
]
