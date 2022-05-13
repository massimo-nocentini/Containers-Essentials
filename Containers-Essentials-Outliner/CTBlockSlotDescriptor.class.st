"
I use the given block to provide a value for the argument.
"
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
CTBlockSlotDescriptor >> valueOn: anObject walker: aDfsWalker [

	^ accessor value
]
