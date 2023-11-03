Class {
	#name : 'CTEssentialsTestRelation',
	#superclass : 'Object',
	#instVars : [
		'left',
		'name',
		'right'
	],
	#category : 'Containers-Essentials-Tests-SUTs',
	#package : 'Containers-Essentials-Tests',
	#tag : 'SUTs'
}

{ #category : 'visiting' }
CTEssentialsTestRelation >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitCTEssentialsTestRelation: self
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> left [

	^ left
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> left: anObject [

	left := anObject
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> name [

	^ name
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> object [

	^ right
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> right [

	^ right
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> right: anObject [

	right := anObject
]

{ #category : 'accessing' }
CTEssentialsTestRelation >> subject [

	^ left
]
