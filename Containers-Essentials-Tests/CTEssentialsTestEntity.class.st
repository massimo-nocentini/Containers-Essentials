"
I am a dummy entity, to test the outliners without headers: an object with a `name`, and a `relation` (`CTEssentialsTestRelation`) with another entity.
"
Class {
	#name : 'CTEssentialsTestEntity',
	#superclass : 'Object',
	#instVars : [
		'name',
		'relation'
	],
	#category : 'Containers-Essentials-Tests-SUTs',
	#package : 'Containers-Essentials-Tests',
	#tag : 'SUTs'
}

{ #category : 'visiting' }
CTEssentialsTestEntity >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTEssentialsTestEntity: self
]

{ #category : 'accessing' }
CTEssentialsTestEntity >> name [

	^ name
]

{ #category : 'accessing' }
CTEssentialsTestEntity >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
CTEssentialsTestEntity >> relation [

	^ relation
]

{ #category : 'accessing' }
CTEssentialsTestEntity >> relation: anObject [

	relation := anObject
]
