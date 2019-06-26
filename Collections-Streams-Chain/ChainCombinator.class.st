Class {
	#name : #ChainCombinator,
	#superclass : #Object,
	#category : #'Collections-Streams-Chain'
}

{ #category : #dispatched }
ChainCombinator >> interleavedStrategy: anInterleaved [
	self subclassResponsibility
]

{ #category : #dispatched }
ChainCombinator >> sequentialStrategy: aSequential [
	self subclassResponsibility
]
