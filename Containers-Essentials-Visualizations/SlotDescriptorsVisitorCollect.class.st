Class {
	#name : #SlotDescriptorsVisitorCollect,
	#superclass : #SlotDescriptorsVisitor,
	#instVars : [
		'blockClosure',
		'slotDescriptorsContext'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> blockClosure [

	^ blockClosure
]

{ #category : #accessing }
SlotDescriptorsVisitorCollect >> blockClosure: anObject [

	blockClosure := anObject
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
