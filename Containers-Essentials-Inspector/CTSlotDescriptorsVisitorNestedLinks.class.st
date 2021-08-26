Class {
	#name : #CTSlotDescriptorsVisitorNestedLinks,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorNestedLinks >> visitLink: aLink [

	^ { (#nextLink asSlotDescriptor
		   blockClosure: [ aLink nextLink asShapeSlotsDfsTree: self ];
		   inline: true;
		   quote) }
]
