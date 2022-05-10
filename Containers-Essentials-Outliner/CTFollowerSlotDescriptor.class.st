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

	| slots value |
	value := self value: walker.

	slots := follower value: value.
	block value: slots value: descriptor
]
