"
I am a variant that stops the visit and provides a follow up outliners to continue the diagram.
"
Class {
	#name : #CTFollowerSlotDescriptor,
	#superclass : #CTDecorateSlotDescriptor,
	#instVars : [
		'follower'
	],
	#category : #'Containers-Essentials-Outliner-Slots'
}

{ #category : #accessing }
CTFollowerSlotDescriptor >> follower: anObject [

	follower := anObject
]

{ #category : #delegating }
CTFollowerSlotDescriptor >> ifHasFollowers: block walker: walker [

	| slots |
	slots := follower value.
	^ block value: slots value: descriptor
]
