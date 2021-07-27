Class {
	#name : #SlotDescriptorsVisitorNestedLinks,
	#superclass : #SlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
SlotDescriptorsVisitorNestedLinks >> visitLink: aLink [

	^ { (#nextLink asSlotDescriptor
		   blockClosure: [ aLink nextLink asShapeSlotsDfsTree: self ];
		   inline: true;
		   quote) }
]
