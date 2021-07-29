Class {
	#name : #PdmRelationCanBeReachedBy,
	#superclass : #PdmRelation,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
PdmRelationCanBeReachedBy >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPdmRelationCanBeReachedBy: self
]
