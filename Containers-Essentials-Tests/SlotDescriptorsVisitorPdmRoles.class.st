Class {
	#name : #SlotDescriptorsVisitorPdmRoles,
	#superclass : #SlotDescriptorsVisitor,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #initialization }
SlotDescriptorsVisitorPdmRoles >> initialize [

	super initialize.

	self rootDescriptor noHeader
]

{ #category : #visiting }
SlotDescriptorsVisitorPdmRoles >> visitDictionary: aDictionary [

	^ Array streamContents: [ :aStream | 
		  aDictionary keysAndValuesDo: [ :k :v | 
			  aStream nextPut: (k asString asSlotDescriptor
					   blockClosure: [ v ];
					   yourself) ] ]
]

{ #category : #visiting }
SlotDescriptorsVisitorPdmRoles >> visitPdmEntity: anEntity [

	^ { 
		  (#id asSlotDescriptor
			   inline: true;
			   blockClosure: [ :anAssoc | anAssoc key ]).
		  (#relations asSlotDescriptor
			   inline: false;
			   blockClosure: [ :anAssoc | anAssoc value ];
			   oneToMany) }
]

{ #category : #visiting }
SlotDescriptorsVisitorPdmRoles >> visitPdmRelation: aRelation [

	^ { (#relation asSlotDescriptor inline: true) }
	  , (aRelation arguments
			   ifEmpty: [ {  } ]
			   ifNotEmpty: [ { (#argument asSlotDescriptor inline: true) } ])
	  , (aRelation object
			   ifNil: [ {  } ]
			   ifNotNil: [ { #object asSlotDescriptor } ])
	"(#subject asSlotDescriptor inline: true)."
]

{ #category : #visiting }
SlotDescriptorsVisitorPdmRoles >> visitPdmRelationCanBeReachedBy: aRelation [

	^ (self visitPdmRelation: aRelation) yourself: [ :descriptors | 
		  descriptors at: descriptors size put: (descriptors last
				   selector: #contacts;
				   blockClosure: [ :anObj | anObj return ];
				   inline: true;
				   noHeader;
				   in: [ :aDescriptor | 
					   aDescriptor quote: [ :anArray | 
							   anArray asShapeSlotsDfsTree: self ] ]) ]
]

{ #category : #visiting }
SlotDescriptorsVisitorPdmRoles >> visitPdmRelationManagesProjectsFor: aRelation [

	^ (self visitPdmRelation: aRelation) yourself: [ :descriptors | 
		  descriptors at: descriptors size put: (descriptors last
				   selector: #projects;
				   oneToMany;
				   blockClosure: [ :anObj | ";
				   inline: false;
				   in: [ :aDescriptor | 
					   aDescriptor quote: [ :anArray | 
							   anArray asShapeSlotsDfsTree: self ] ]" 
					   anObj return asArray ]) ]
]
