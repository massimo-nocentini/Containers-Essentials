Class {
	#name : #PdmRelationManagesProjectsFor,
	#superclass : #PdmRelation,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
PdmRelationManagesProjectsFor >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPdmRelationManagesProjectsFor: self
]
