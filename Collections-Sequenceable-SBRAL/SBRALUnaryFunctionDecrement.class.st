Class {
	#name : #SBRALUnaryFunctionDecrement,
	#superclass : #SkewBinaryCanonicalNumberUnaryFunctionDecrement,
	#category : #'Collections-Sequenceable-SBRAL'
}

{ #category : #'as yet unclassified' }
SBRALUnaryFunctionDecrement >> decrementBitZeroOrTwo: anAssociation by: v onto: aRepresentation [
	| sbral |
	sbral := super
		decrementBitZeroOrTwo: anAssociation
		by: v
		onto: aRepresentation.
	^ anAssociation value decrementSBRAL: sbral
]
