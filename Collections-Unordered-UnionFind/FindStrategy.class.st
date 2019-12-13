Class {
	#name : #FindStrategy,
	#superclass : #Object,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
FindStrategy >> at: x in: dict [
	self subclassResponsibility
]
