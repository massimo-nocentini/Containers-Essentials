"
I am a variant that decorates a slot descriptors visitor by collecting the collection by a given block.
"
Class {
	#name : 'CTSlotDescriptorsVisitorCollect',
	#superclass : 'CTSlotDescriptorsVisitor',
	#instVars : [
		'collectBlock',
		'slotDescriptorsVisitor'
	],
	#category : 'Containers-Essentials-Outliner-Slots',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Slots'
}

{ #category : 'accessing' }
CTSlotDescriptorsVisitorCollect >> collectBlock: anObject [

	collectBlock := anObject
]

{ #category : 'initialization' }
CTSlotDescriptorsVisitorCollect >> initialize [

	super initialize.

	self rootDescriptor:
		(collectBlock value: slotDescriptorsVisitor rootDescriptor)
]

{ #category : 'accessing' }
CTSlotDescriptorsVisitorCollect >> slotDescriptorsVisitor: anObject [

	slotDescriptorsVisitor := anObject
]

{ #category : 'visiting' }
CTSlotDescriptorsVisitorCollect >> visit: anObject [

	^ (slotDescriptorsVisitor visit: anObject) collect: collectBlock
]
