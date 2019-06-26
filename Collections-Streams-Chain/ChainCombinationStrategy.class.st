Class {
	#name : #ChainCombinationStrategy,
	#superclass : #Object,
	#category : #'Collections-Streams-Chain'
}

{ #category : #dispatching }
ChainCombinationStrategy >> of: aStreamCombination [
	self subclassResponsibility
]
