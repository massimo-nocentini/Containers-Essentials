Class {
	#name : #Interleaved,
	#superclass : #ChainCombinationStrategy,
	#category : #'Collections-Streams-Chain'
}

{ #category : #dispatching }
Interleaved >> of: aStreamCombination [
	^ aStreamCombination interleavedStrategy: self
]
