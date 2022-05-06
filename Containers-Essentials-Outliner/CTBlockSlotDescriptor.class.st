Class {
	#name : #CTBlockSlotDescriptor,
	#superclass : #CTBaseSlotDescriptor,
	#instVars : [
		'accessor'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTBlockSlotDescriptor >> accessor: anObject [

	accessor := anObject
]

{ #category : #accessing }
CTBlockSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ accessor value
]
