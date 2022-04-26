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

	^ { (self newSlotDescriptor
		   selector: #nextLink;
		   blockClosure: [ :anObj :aSelector :aDfsWalker | 
			   aLink nextLink asShapeSlotsDfsTree: aDfsWalker ];
		   inline;
		   quote) }
]
