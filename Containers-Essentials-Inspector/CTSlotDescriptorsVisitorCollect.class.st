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
CTSlotDescriptorsVisitorCollect >> blockClosure [

	^ blockClosure
]

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #initialization }
CTSlotDescriptorsVisitorCollect >> initialize [

	super initialize.

	self rootDescriptor:
		(self blockClosure value: self slotDescriptorsContext rootDescriptor)
]

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> slotDescriptorsContext [

	^ slotDescriptorsContext
]

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> slotDescriptorsContext: anObject [

	slotDescriptorsContext := anObject
]

{ #category : #visiting }
CTSlotDescriptorsVisitorCollect >> visit: anObject [

	^ (self slotDescriptorsContext visit: anObject) collect:
		  self blockClosure
]
