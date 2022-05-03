Class {
	#name : #CTBlockSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#instVars : [
		'accessor'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTBlockSlotDescriptor >> accessor: anObject [

	accessor := anObject
]

{ #category : #accessing }
CTBlockSlotDescriptor >> on: anObject [

	^ accessor value
]
