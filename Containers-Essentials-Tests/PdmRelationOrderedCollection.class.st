Class {
	#name : #PdmRelationOrderedCollection,
	#superclass : #OrderedCollection,
	#category : #'Containers-Essentials-Tests'
}

{ #category : #'as yet unclassified' }
PdmRelationOrderedCollection >> instVarsNamesOrderedCollection [

	^ self asArray instVarsNamesOrderedCollection collect: [ :each | 
		  each inline: true ]
]
