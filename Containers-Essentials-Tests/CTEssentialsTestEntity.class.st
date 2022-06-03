Class {
	#name : #CTEssentialsTestEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'relation'
	],
	#category : #'Containers-Essentials-Tests'
}

{ #category : #visiting }
CTEssentialsTestEntity >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTEssentialsTestEntity: self
]

{ #category : #accessing }
CTEssentialsTestEntity >> name [

	^ name
]

{ #category : #accessing }
CTEssentialsTestEntity >> name: anObject [

	name := anObject
]

{ #category : #accessing }
CTEssentialsTestEntity >> relation [

	^ relation
]

{ #category : #accessing }
CTEssentialsTestEntity >> relation: anObject [

	relation := anObject
]
