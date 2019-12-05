Class {
	#name : #WeightedAssociation,
	#superclass : #Association,
	#instVars : [
		'weightBlock'
	],
	#category : #'Collections-Unordered-Graph'
}

{ #category : #accessing }
WeightedAssociation >> asEdge [
	^ super asEdge
		weight: self weight;
		yourself
]

{ #category : #accessing }
WeightedAssociation >> weight [
	^ weightBlock
]

{ #category : #accessing }
WeightedAssociation >> weight: aWeight [
	weightBlock := aWeight
]
