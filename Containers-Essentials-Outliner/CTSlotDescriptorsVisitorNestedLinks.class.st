"
I am a variant that customizes the way we look at ValueLink objects, by nesting the #nextLink slot recursively.
"
Class {
	#name : #CTSlotDescriptorsVisitorNestedLinks,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorNestedLinks >> visitLink: aLink [

	^ { (#nextLink asSlotDescriptor
		   blockClosure: [ aLink nextLink asShapeSlotsDfsTree: self ];
		   inline: true;
		   quote) }
]
