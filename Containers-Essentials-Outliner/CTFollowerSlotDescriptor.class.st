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
CTFollowerSlotDescriptor >> ifHasFollowers: block [

	^ descriptor model ifNothing: [ Error signal ] ifJust: [ :just | 
		  | slots v |
		  v := self value
			       ifNothing: [ Error signal ]
			       ifJust: [ :valueJust | valueJust content ].
		  slots := follower value: v.
		  block value: slots value: just content value: descriptor ]
]

{ #category : #accessing }
CTFollowerSlotDescriptor >> shape: anObject walker: aDfsWalker [

	^ descriptor shape: anObject walker: aDfsWalker
]
