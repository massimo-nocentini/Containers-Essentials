Class {
	#name : #CTSlotDescriptorsVisitorCollect,
	#superclass : #CTSlotDescriptorsVisitor,
	#instVars : [
		'blockClosure',
		'slotDescriptorsContext'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #initialization }
CTSlotDescriptorsVisitorCollect >> initialize [

	super initialize.

	self rootDescriptor:
		(blockClosure value: slotDescriptorsContext rootDescriptor)
]

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> slotDescriptorsContext: anObject [

	slotDescriptorsContext := anObject
]

{ #category : #visiting }
CTSlotDescriptorsVisitorCollect >> visit: anObject [

	^ (slotDescriptorsContext visit: anObject) collect: blockClosure
]
