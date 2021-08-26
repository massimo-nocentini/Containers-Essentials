"
I am a variant that sets up my super class to take care of Strongly Connected Components.
"
Class {
	#name : #CTBaseSccDfsPainter,
	#superclass : #CTDfsPainter,
	#instVars : [
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTBaseSccDfsPainter >> visit [

	shapeBySCC := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	visit stronglyConnectedComponents: stronglyConnectedComponents.

	^ super visit
]
