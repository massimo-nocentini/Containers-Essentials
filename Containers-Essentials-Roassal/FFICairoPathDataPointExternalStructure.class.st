Class {
	#name : #FFICairoPathDataPointExternalStructure,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'library path' }
FFICairoPathDataPointExternalStructure class >> ffiLibraryName [
	^ CairoLibrary
]

{ #category : #'field definition' }
FFICairoPathDataPointExternalStructure class >> fieldsDesc [

	"self rebuildFieldAccessors"

	^ #( double x; double y; )
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataPointExternalStructure >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataPointExternalStructure >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataPointExternalStructure >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataPointExternalStructure >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
