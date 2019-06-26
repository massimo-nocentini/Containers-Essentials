Class {
	#name : #DLColumnObject,
	#superclass : #DLDataObject,
	#instVars : [
		'size',
		'name',
		'root'
	],
	#category : #'Collections-DoubleLinkedList-DancingLinks-dancing objects'
}

{ #category : #modifying }
DLColumnObject >> cover [
	we remove.
	self untilFixPointOf: #down do: [ :i |
		i untilFixPointOf: #right do: [ :j |
			j nsLink remove.
			j column updateSize: [:s | s -1].
			 ]
		 ] 
]

{ #category : #accessing }
DLColumnObject >> root [
	^ root
]

{ #category : #accessing }
DLColumnObject >> root: anObject [
	root := anObject
]

{ #category : #accessing }
DLColumnObject >> size [
^ size
]

{ #category : #accessing }
DLColumnObject >> size: anInteger [ 
	size := anInteger
]

{ #category : #modifying }
DLColumnObject >> uncover [
	self
		untilFixPointOf: #up
		do: [ :i | 
			i
				untilFixPointOf: #left
				do: [ :j | 
					j column updateSize: [ :s | s + 1 ].
					j nsLink restore ] ].
			we restore.
]

{ #category : #'modifier state' }
DLColumnObject >> updateSize: aBlock [
	size := aBlock value: size
]
