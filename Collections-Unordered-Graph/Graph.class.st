Class {
	#name : #Graph,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #'Collections-Unordered-Graph'
}

{ #category : #converting }
Graph >> asGoal [
	^ [:x :y | 
	| g |
	g := Goal cond e.
	edges
		do: [:each | g
				if: (x unifyo value: (each key))
				then: (y unifyo value: (each value))].
	g]
]

{ #category : #accessing }
Graph >> edges [
	^ edges
]

{ #category : #accessing }
Graph >> edges: anObject [
	edges := anObject
]

{ #category : #initialization }
Graph >> initialize [
	
	self class initializeSlots: self.
	vertices := Dictionary new.
	edges := LinkedList new " we don't care about ordering, just the chronological one for insertion time"
]

{ #category : #accessing }
Graph >> vertices [
	^ vertices
]

{ #category : #accessing }
Graph >> vertices: anObject [
	vertices := anObject
]
