Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copybits: aByteArray [
	^ aByteArray
		replaceFrom: 1
		to: self size
		with: self
		startingAt: 1
]
