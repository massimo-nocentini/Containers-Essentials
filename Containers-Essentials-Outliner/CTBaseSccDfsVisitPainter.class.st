Class {
	#name : #CTBaseSccDfsVisitPainter,
	#superclass : #CTDfsVisitPainter,
	#instVars : [
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTBaseSccDfsVisitPainter >> visit [

	shapeBySCC := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	visit stronglyConnectedComponents: stronglyConnectedComponents.

	^ super visit
]
