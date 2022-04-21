Class {
	#name : #FFICairoPathDataExternalStructure,
	#superclass : #FFIUnion,
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'library path' }
FFICairoPathDataExternalStructure class >> ffiLibraryName [
	^ CairoLibrary
]

{ #category : #'field definition' }
FFICairoPathDataExternalStructure class >> fieldsDesc [
	"self rebuildFieldAccessors" 
	^ #(
 	 FFICairoPathDataHeaderExternalStructure header;
	 FFICairoPathDataPointExternalStructure point;
	)
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataExternalStructure >> header [
	"This method was automatically generated"
	^ FFICairoPathDataHeaderExternalStructure fromHandle: (handle referenceStructAt: 1 length: FFICairoPathDataHeaderExternalStructure byteSize)
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataExternalStructure >> header: anObject [
	"This method was automatically generated"
	handle structAt: 1 put: anObject getHandle length: 8.
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataExternalStructure >> point [
	"This method was automatically generated"
	^ FFICairoPathDataPointExternalStructure fromHandle: (handle referenceStructAt: 1 length: FFICairoPathDataPointExternalStructure byteSize)
]

{ #category : #'accessing - structure variables' }
FFICairoPathDataExternalStructure >> point: anObject [
	"This method was automatically generated"
	handle structAt: 1 put: anObject getHandle length: 16.
]
