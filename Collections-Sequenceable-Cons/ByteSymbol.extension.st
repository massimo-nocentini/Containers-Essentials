Extension { #name : #ByteSymbol }

{ #category : #'*Collections-Sequenceable-Cons' }
ByteSymbol >> asCons [
	^ Cons fromByteSymbol: self
]
