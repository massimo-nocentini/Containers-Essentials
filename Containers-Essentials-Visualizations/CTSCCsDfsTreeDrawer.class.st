Class {
	#name : #CTSCCsDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#instVars : [
		'stronglyConnectedComponents',
		'shapeBySCC'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #accessing }
CTSCCsDfsTreeDrawer >> visit [

	shapeBySCC := IdentityDictionary new.
	stronglyConnectedComponents := OrderedCollection new.

	visit stronglyConnectedComponents: stronglyConnectedComponents.

	^ super visit
]
