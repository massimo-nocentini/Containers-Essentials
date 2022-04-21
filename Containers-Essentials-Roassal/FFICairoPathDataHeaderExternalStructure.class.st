Class {
	#name : #FFICairoPathDataHeaderExternalStructure,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_LENGTH',
		'OFFSET_TYPE'
	],
	#pools : [
		'FFICairoPathDataTypeEnumeration'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'library path' }
FFICairoPathDataHeaderExternalStructure class >> ffiLibraryName [
	^ CairoLibrary
]

{ #category : #'field definition' }
FFICairoPathDataHeaderExternalStructure class >> fieldsDesc [

	"self rebuildFieldAccessors"

	^ #( 
			FFICairoPathDataTypeEnumeration type; 
			int length; )
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataHeaderExternalStructure >> length [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_LENGTH
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataHeaderExternalStructure >> length: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_LENGTH put: anObject
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataHeaderExternalStructure >> type [
	"This method was automatically generated"
	^FFICairoPathDataTypeEnumeration fromInteger: (handle unsignedLongAt: OFFSET_TYPE)
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataHeaderExternalStructure >> type: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TYPE put: anObject value
]
