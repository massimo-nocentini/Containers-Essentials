Class {
	#name : #PdmRelation,
	#superclass : #MessageSent,
	#category : #'Containers-Essentials'
}

{ #category : #'as yet unclassified' }
PdmRelation >> argument [

	^ self arguments first
]

{ #category : #'as yet unclassified' }
PdmRelation >> instVarsNamesOrderedCollection [

	^ { 
		  (#subject asSlotDescriptor inline: true).
		  (#relation asSlotDescriptor inline: true) } , (self arguments
		   ifEmpty: [ {  } ]
		   ifNotEmpty: [ { (#argument asSlotDescriptor inline: true) } ])
	  , (self object
			   ifNil: [ {  } ]
			   ifNotNil: [ { #object asSlotDescriptor } ])
]

{ #category : #accessing }
PdmRelation >> object [

	^ self return
]

{ #category : #'as yet unclassified' }
PdmRelation >> relation [

	^ self selector
]

{ #category : #accessing }
PdmRelation >> subject [

	^ self receiver
]
