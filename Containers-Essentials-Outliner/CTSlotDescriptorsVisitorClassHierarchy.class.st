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
		  aStream nextPut: (self newSlotDescriptor selector: #name).

		  aClass instVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut: (self newSlotDescriptor
					   selector: #instVarNames;
					   inline;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :sourceObject :anArray :aDfsWalker | 
								   anArray asShapeSlotsDfsTree: aDfsWalker ] ]) ].

		  aClass classVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline)."
			  aStream nextPut: (self newSlotDescriptor
					   selector: #classVarNames;
					   inline;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :sourceObject :anArray :aDfsWalker | 
								   anArray asShapeSlotsDfsTree: aDfsWalker ] ]) ].

		  aClass subclasses ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut: (self newSlotDescriptor
					   selector: #subclasses;
					   yourself: [ :aDescriptor | 
						   aClass subclasses isEmpty ifTrue: [ aDescriptor inline ] ]) ] ]
]
