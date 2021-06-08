Class {
	#name : #CTKeysAndValuesView,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'Containers-Essentials-Views'
}

{ #category : #accessing }
CTKeysAndValuesView >> dictionary: anObject [

	dict := anObject
]

{ #category : #'as yet unclassified' }
CTKeysAndValuesView >> instVarsNamesOrderedCollection [

	^ Array streamContents: [ :aStream | 
		  dict keysAndValuesDo: [ :k :v | 
			  aStream nextPut: k asString -> [ :anObj | v ] ] ]
]
