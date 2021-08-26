Class {
	#name : #CTSCCsDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#instVars : [
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #accessing }
CTSCCsDfsTreeDrawer >> visit [

	shapeBySCC := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	visit stronglyConnectedComponents: stronglyConnectedComponents.

	^ super visit
]
