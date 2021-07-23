Class {
	#name : #PdmRelationCanBeReachedBy,
	#superclass : #PdmRelation,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #'as yet unclassified' }
PdmRelationCanBeReachedBy >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection yourself: [ :descriptors | 
		  descriptors at: descriptors size put: (descriptors last
				   selector: #contacts;
				   blockClosure: [ :anObj | anObj return ];
				   inline: true;
				   noHeader;
				   in: [ :aDescriptor | 
					   aDescriptor quote: [ :anArray | 
							   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ] ]) ]
]
