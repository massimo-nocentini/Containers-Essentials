"
I am a variant that customize the slot descriptors for Class objects.
"
Class {
	#name : #CTSlotDescriptorsVisitorClassHierarchy,
	#superclass : #CTSlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #visiting }
CTSlotDescriptorsVisitorClassHierarchy >> visitClass: aClass [

	^ Array streamContents: [ :aStream | 
		  aStream nextPut: (self newSlotDescriptorSelector: #name).

		  aClass instVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut:
				  ((self newSlotDescriptorSelector: #instVarNames)
					   inline;
					   noHeader;
					   quote: [ :anArray :aDfsWalker | 
						   anArray asShapeSlotsDfsTree: aDfsWalker ]) ].

		  aClass classVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline)."
			  aStream nextPut:
				  ((self newSlotDescriptorSelector: #classVarNames)
					   inline;
					   noHeader;
					   quote: [ :anArray :aDfsWalker | 
						   anArray asShapeSlotsDfsTree: aDfsWalker ]) ].

		  aClass subclasses ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut:
				  ((self newSlotDescriptorSelector: #subclasses) yourself: [ 
					   :aDescriptor | 
					   aClass subclasses isEmpty ifTrue: [ aDescriptor inline ] ]) ] ]
]
