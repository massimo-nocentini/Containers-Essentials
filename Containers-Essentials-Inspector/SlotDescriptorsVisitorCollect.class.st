Class {
	#name : #SlotDescriptorsVisitorCollect,
	#superclass : #SlotDescriptorsVisitor,
	#instVars : [
		'blockClosure',
		'slotDescriptorsContext'
	],
	#category : #'Containers-Essentials-Inspector'
}

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> blockClosure [

	^ blockClosure
]

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> blockClosure: anObject [

	blockClosure := anObject
]

{ #category : #initialization }
SlotDescriptorsVisitorCollect >> initialize [

	super initialize.

	self rootDescriptor:
		(self blockClosure value: self slotDescriptorsContext rootDescriptor)
]

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> slotDescriptorsContext [

	^ slotDescriptorsContext
]

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> slotDescriptorsContext: anObject [

	slotDescriptorsContext := anObject
]

{ #category : #visiting }
SlotDescriptorsVisitorCollect >> visit: anObject [

	^ (self slotDescriptorsContext visit: anObject) collect:
		  self blockClosure
]
