Class {
	#name : #EssentialsObjectTest,
	#superclass : #ObjectTest,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests'
}

{ #category : #tests }
EssentialsObjectTest >> testInspectObjectClass [

	^ self exportSlotsGraphOf: Object
]

{ #category : #tests }
EssentialsObjectTest >> testInspectTraitClass [

	^ self exportSlotsGraphOf: Trait
]
