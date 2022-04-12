"
I am a variant that customize the slot descriptors for Class objects.
"
Class {
	#name : #CTSlotDescriptorsVisitorClassHierarchy,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorClassHierarchy >> visitClass: aClass [

	^ Array streamContents: [ :aStream | 
		  aStream nextPut: #name asSlotDescriptor.

		  aClass instVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut: (#instVarNames asSlotDescriptor
					   inline;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :sourceObject :anArray :aDfsWalker | 
								   anArray asShapeSlotsDfsTree: aDfsWalker ] ]) ].

		  aClass classVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline)."
			  aStream nextPut: (#classVarNames asSlotDescriptor
					   inline;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :sourceObject :anArray :aDfsWalker | 
								   anArray asShapeSlotsDfsTree: aDfsWalker ] ]) ].

		  aClass subclasses ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut:
				  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
					   aClass subclasses isEmpty ifTrue: [ aDescriptor inline ] ]) ] ]
]
