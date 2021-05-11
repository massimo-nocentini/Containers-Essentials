Class {
	#name : #CTSlotsDrawer,
	#superclass : #Object,
	#instVars : [
		'visit'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'as yet unclassified' }
CTSlotsDrawer >> drawOnCanvas: aCanvas [

	self subclassResponsibility
]

{ #category : #accessing }
CTSlotsDrawer >> visit: anObject [

	visit := anObject
]
