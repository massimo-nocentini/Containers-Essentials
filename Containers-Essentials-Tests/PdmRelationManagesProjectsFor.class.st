Class {
	#name : #PdmRelationManagesProjectsFor,
	#superclass : #PdmRelation,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #'as yet unclassified' }
PdmRelationManagesProjectsFor >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection yourself: [ :descriptors | 
		  descriptors at: descriptors size put: (descriptors last
				   selector: #projects;
				   blockClosure: [ :anObj | anObj return ];
				   inline: true;
				   noHeader;
				   in: [ :aDescriptor | 
					   aDescriptor quote: [ :anArray | 
							   anArray asShapeSlotsDfsTreeInitialDescriptor: aDescriptor ] ]) ]
]
