"
I am a message that has been sent: a `messageSend` with its `return`. `MessageSend>>#return:` makes me.

```smalltalk
| send |
send := MessageSend receiver: 3 selector: #+ argument: 4.
(send return: send value) return ""7""
```

Two of us are equal if their message sends are equal and their returns are the same object.
"
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
