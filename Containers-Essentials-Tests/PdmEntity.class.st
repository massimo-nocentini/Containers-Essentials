Class {
	#name : #PdmEntity,
	#superclass : #Association,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
PdmEntity >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPdmEntity: self
]
