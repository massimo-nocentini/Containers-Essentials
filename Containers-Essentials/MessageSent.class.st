Class {
	#name : 'MessageSent',
	#superclass : 'Object',
	#instVars : [
		'messageSend',
		'return'
	],
	#category : 'Containers-Essentials-Messaging',
	#package : 'Containers-Essentials',
	#tag : 'Messaging'
}

{ #category : 'comparing' }
MessageSent >> = anObject [

	^ anObject species == self species and: [ 
		  self messageSend = anObject messageSend and: [ 
			  self return == anObject return ] ]
]

{ #category : 'comparing' }
MessageSent >> hash [

	^ messageSend hash bitXor: return hash
]

{ #category : 'accessing' }
MessageSent >> messageSend [

	^ messageSend
]

{ #category : 'accessing' }
MessageSent >> messageSend: anObject [

	messageSend := anObject
]

{ #category : 'accessing' }
MessageSent >> return [

	^ return
]

{ #category : 'accessing' }
MessageSent >> return: anObject [

	^ return := anObject
]
