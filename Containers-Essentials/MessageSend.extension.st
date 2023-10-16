Extension { #name : 'MessageSend' }

{ #category : '*Containers-Essentials' }
MessageSend >> return: anObject [

	^ MessageSent new
		  messageSend: self;
		  return: anObject;
		  yourself
]
