Extension { #name : 'CollectionElement' }

{ #category : '*Containers-Essentials' }
CollectionElement >> ifNil: nBlock ifEnclosed: jBlock [

	^ self == NilElement
		  ifTrue: nBlock
		  ifFalse: [ jBlock value: self enclosedElement ]
]
