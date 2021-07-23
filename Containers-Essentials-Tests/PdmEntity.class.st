Class {
	#name : #PdmEntity,
	#superclass : #Association,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #'as yet unclassified' }
PdmEntity >> instVarsNamesOrderedCollection [

	^ { 
		  (#id asSlotDescriptor
			   inline: true;
			   blockClosure: [ :anAssoc | anAssoc key ]).
		  (#relations asSlotDescriptor
			   inline: true;
			   noHeader;
			   blockClosure: [ :anAssoc | anAssoc value ];
			   in: [ :aDescriptor | 
				   aDescriptor quote: [ :anArray | 
						   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ] ]) }
]
