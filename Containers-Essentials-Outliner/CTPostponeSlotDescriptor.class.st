"
I am a variant that allows the client to postpone the visit of an object.
"
Class {
	#name : 'CTPostponeSlotDescriptor',
	#superclass : 'CTDecorateSlotDescriptor',
	#instVars : [
		'post'
	],
	#category : 'Containers-Essentials-Outliner-Slots',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Slots'
}

{ #category : 'dispatching' }
CTPostponeSlotDescriptor >> dispatchPostponed: child data: data walker: walker otherwise: oBlock [
	"Dispatch by hand to not mess up Boolean and BlockClosure."

	^ post == true
		  ifTrue: [
			  walker
				  postponedTrue: post
				  child: child
				  data: data
				  descriptor: descriptor ]
		  ifFalse: [
			  post isAssociation
				  ifTrue: [
					  walker
						  postponedBlockClosure: post key
						  backToBlock: post value
						  child: child
						  data: data
						  descriptor: descriptor ]
				  ifFalse: oBlock ]
]

{ #category : 'accessing' }
CTPostponeSlotDescriptor >> post: anObject [

	post := anObject
]
