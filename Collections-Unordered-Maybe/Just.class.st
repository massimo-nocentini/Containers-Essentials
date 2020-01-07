Class {
	#name : #Just,
	#superclass : #Maybe,
	#instVars : [
		'content'
	],
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #accessing }
Just >> content [
	^ content
]

{ #category : #accessing }
Just >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
Just >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]
