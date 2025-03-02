"
I am a variant that sets up my super class to take care of Strongly Connected Components.
"
Class {
	#name : 'CTBaseSccDfsPainter',
	#superclass : 'CTDfsPainter',
	#instVars : [
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : 'Containers-Essentials-Outliner-Painters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Painters'
}

{ #category : 'DFS' }
CTBaseSccDfsPainter >> dfsWalk: anObject [

	shapeBySCC := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	dfsWalker stronglyConnectedComponents: stronglyConnectedComponents.

	^ super dfsWalk: anObject
]
