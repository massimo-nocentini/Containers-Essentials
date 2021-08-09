Class {
	#name : #SlotDescriptorsVisitorClassHierarchy,
	#superclass : #SlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
SlotDescriptorsVisitorClassHierarchy >> visitClass: aClass [

	^ Array streamContents: [ :aStream | 
		  aStream nextPut: #name asSlotDescriptor.

		  aClass instVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut: (#instVarNames asSlotDescriptor
					   inline: true;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :anArray | 
								   anArray asShapeSlotsDfsTree:
										   (self copy yourself: [ :sdc | 
												    sdc rootDescriptor noHeader ]) ] ]) ].

		  aClass classVarNames ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut: (#classVarNames asSlotDescriptor
					   inline: true;
					   noHeader;
					   in: [ :aDescriptor | 
						   aDescriptor quote: [ :anArray | 
								   anArray asShapeSlotsDfsTree:
										   (self copy yourself: [ :sdc | 
												    sdc rootDescriptor noHeader ]) ] ]) ].

		  aClass subclasses ifNotEmpty: [ "(#comment asSlotDescriptor inline: true)."
			  aStream nextPut:
				  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
					   aDescriptor inline: aClass subclasses isEmpty ]) ] ]
]
