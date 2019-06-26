Extension { #name : #BlockClosure }

{ #category : #'*Collections-Streams-Chain' }
BlockClosure >> consedObject: car [

 ^ Chain item: car linker: self suspended
]

{ #category : #'*Collections-Streams-Chain' }
BlockClosure >> suspended [

	^ (Suspended new block: self; yourself)
]
