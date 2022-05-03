"
I am a variant that decorates a slot descriptors visitor by collecting the collection by a given block.
"
Class {
	#name : #CTSlotDescriptorsVisitorCollect,
	#superclass : #CTSlotDescriptorsVisitor,
	#instVars : [
		'slotDescriptorsContext',
		'collectBlock'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> collectBlock: anObject [

	collectBlock := anObject
]

{ #category : #initialization }
CTSlotDescriptorsVisitorCollect >> initialize [

	super initialize.

	self rootDescriptor:
		(collectBlock value: slotDescriptorsContext rootDescriptor)
]

{ #category : #accessing }
CTSlotDescriptorsVisitorCollect >> slotDescriptorsContext: anObject [

	slotDescriptorsContext := anObject
]

{ #category : #visiting }
CTSlotDescriptorsVisitorCollect >> visit: anObject [

	^ (slotDescriptorsContext visit: anObject) collect: collectBlock
]
