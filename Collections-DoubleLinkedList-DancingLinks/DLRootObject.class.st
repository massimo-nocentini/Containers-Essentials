Class {
	#name : #DLRootObject,
	#superclass : #DLColumnObject,
	#category : #'Collections-DoubleLinkedList-DancingLinks-dancing objects'
}

{ #category : #accessing }
DLRootObject >> chooseColumn [
	| c s |
	s := Float infinity.
	self
		untilFixPointOf: #right
		do: [ :j | 
			j size < s
				ifTrue: [ c := j.
					s := j size ] ].
	^ c
]

{ #category : #accessing }
DLRootObject >> column [
	self shouldNotImplement
]

{ #category : #accessing }
DLRootObject >> down [
	^ nil
]

{ #category : #accessing }
DLRootObject >> size [
	self shouldNotImplement 
]

{ #category : #accessing }
DLRootObject >> up [
	^ nil
]
