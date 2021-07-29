Class {
	#name : #SlotDescriptorsVisitorClassHierarchy,
	#superclass : #SlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #visiting }
SlotDescriptorsVisitorClassHierarchy >> visitClass: aClass [

	^ { 
		  #name asSlotDescriptor.
		  "(#comment asSlotDescriptor inline: true)."
		  (#instVarNames asSlotDescriptor
			   inline: true;
			   noHeader;
			   in: [ :aDescriptor | 
				   aDescriptor quote: [ :anArray | 
						   anArray asShapeSlotsDfsTree:
								   (self copy yourself: [ :sdc | sdc rootDescriptor noHeader ]) ] ]).
		  (#classVarNames asSlotDescriptor
			   inline: true;
			   noHeader;
			   in: [ :aDescriptor | 
				   aDescriptor quote: [ :anArray | 
						   anArray asShapeSlotsDfsTree:
								   (self copy yourself: [ :sdc | sdc rootDescriptor noHeader ]) ] ]).
		  (#subclasses asSlotDescriptor yourself: [ :aDescriptor | 
			   aDescriptor inline: aClass subclasses isEmpty ]) }
]
