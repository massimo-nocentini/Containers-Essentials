"
I am a message send with the timespan of its execution: the data that `RSUMLSequenceBuilder` draws.

	RSUMLTimedMessageSend
		messageSend: ((RSFullMessageSend receiver: #(3 1 2) selector: #asSortedCollection)
			client: self;
			callerSelector: thisContext selector;
			yourself)
		timespan: (Timespan starting: DateAndTime now duration: 5 milliSeconds)
"
Class {
	#name : 'RSUMLTimedMessageSend',
	#superclass : 'Object',
	#instVars : [
		'messageSend',
		'timespan'
	],
	#category : 'Containers-Essentials-UML-Descriptor',
	#package : 'Containers-Essentials-UML',
	#tag : 'Descriptor'
}

{ #category : 'instance creation' }
RSUMLTimedMessageSend class >> messageSend: aMessageSend timespan: aTimespan [

	^ self new
		  messageSend: aMessageSend;
		  timespan: aTimespan;
		  yourself
]

{ #category : 'accessing' }
RSUMLTimedMessageSend >> messageSend [

	^ messageSend
]

{ #category : 'accessing' }
RSUMLTimedMessageSend >> messageSend: aMessageSend [

	messageSend := aMessageSend
]

{ #category : 'printing' }
RSUMLTimedMessageSend >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPut: $(;
		print: messageSend;
		nextPutAll: ', ';
		print: timespan;
		nextPut: $)
]

{ #category : 'accessing' }
RSUMLTimedMessageSend >> timespan [

	^ timespan
]

{ #category : 'accessing' }
RSUMLTimedMessageSend >> timespan: aTimespan [

	timespan := aTimespan
]
