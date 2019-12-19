Class {
	#name : #FindStrategy,
	#superclass : #Object,
	#category : #'Collections-Unordered-UnionFind'
}

{ #category : #accessing }
FindStrategy >> at: x in: dict [
	^ self at: x in: dict select: [ :each | false ]
]

{ #category : #accessing }
FindStrategy >> at: x in: dict select: aBlock [
	self subclassResponsibility
]
