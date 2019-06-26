Class {
	#name : #Sequential,
	#superclass : #ChainCombinationStrategy,
	#category : #'Collections-Streams-Chain'
}

{ #category : #dispatching }
Sequential >> of: aStreamCombination [
	^ aStreamCombination sequentialStrategy: self
]
