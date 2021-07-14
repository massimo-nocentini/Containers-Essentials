Class {
	#name : #EssentialsObjectTest,
	#superclass : #ObjectTest,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-Essentials-Tests'
}

{ #category : #tests }
EssentialsObjectTest >> testCollectionSubclasses [

	^ self exportShapeOf: Collection accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testInspectObjectClass [

	^ self exportSlotsGraphOf: Object
]

{ #category : #tests }
EssentialsObjectTest >> testInspectTraitClass [

	^ self exportSlotsGraphOf: Trait
]

{ #category : #tests }
EssentialsObjectTest >> testMagnitudeSubclasses [

	^ self exportShapeOf: Magnitude accessorBlock: #asShapeSubclasses
]

{ #category : #tests }
EssentialsObjectTest >> testRBNodeSubclasses [

	^ self exportShapeOf: RBNode accessorBlock: #asShapeSubclasses
]
