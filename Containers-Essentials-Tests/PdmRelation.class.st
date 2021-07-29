Class {
	#name : #PdmRelation,
	#superclass : #MessageSent,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
PdmRelation >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitPdmRelation: self
]

{ #category : #'as yet unclassified' }
PdmRelation >> argument [

	^ self arguments first
]

{ #category : #accessing }
PdmRelation >> object [

	^ self return
]

{ #category : #'as yet unclassified' }
PdmRelation >> relation [

	^ self selector
]

{ #category : #accessing }
PdmRelation >> subject [

	^ self receiver
]
