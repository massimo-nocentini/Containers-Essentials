Class {
	#name : #BlockSlotDescriptor,
	#superclass : #PropertySlotDescriptor,
	#instVars : [
		'blockClosure',
		'receiver'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
BlockSlotDescriptor >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #'as yet unclassified' }
BlockSlotDescriptor >> ifQuotation: qBlock ifNotQuotation: nqBlock [

	^ nqBlock value: value
]

{ #category : #accessing }
BlockSlotDescriptor >> value: anObject [

	^ value := blockClosure value: anObject
]
