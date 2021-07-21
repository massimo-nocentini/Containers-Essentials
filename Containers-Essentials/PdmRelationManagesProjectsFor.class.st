Class {
	#name : #PdmRelationManagesProjectsFor,
	#superclass : #PdmRelation,
	#category : #'Containers-Essentials'
}

{ #category : #'as yet unclassified' }
PdmRelationManagesProjectsFor >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection yourself: [ :descriptors | 
		  descriptors at: descriptors size put: (descriptors last
				   selector: #projects;
				   blockClosure: [ :anObj | anObj return ];
				   inline: true;
				   quote: #asShapeSlotsDfsTree) ]
]
