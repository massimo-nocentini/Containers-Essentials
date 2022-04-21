Class {
	#name : #FFICairoPathExternalStructure,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_DATA',
		'OFFSET_NUM_DATA',
		'OFFSET_STATUS'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'library path' }
FFICairoPathExternalStructure class >> ffiLibraryName [
	^ CairoLibrary
]

{ #category : #'library path' }
FFICairoPathExternalStructure class >> fieldsDesc [
	"self rebuildFieldAccessors"
	^ #(
   int status;
	void *data;
	int num_data;
	)
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> data [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DATA) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> data: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DATA put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> num_data [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NUM_DATA
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> num_data: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NUM_DATA put: anObject
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> status [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_STATUS
]

{ #category : #'accessing - structure variables' }
FFICairoPathExternalStructure >> status: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_STATUS put: anObject
]
