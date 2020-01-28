Extension { #name : #UndefinedObject }

{ #category : #'*Kernel-Extensions' }
UndefinedObject >> asLinkedList [
	^ LinkedList empty
]

{ #category : #'*Kernel-Extensions' }
UndefinedObject >> reversed [
	^ self
]

{ #category : #'*Kernel-Extensions' }
UndefinedObject >> reversed: prefix [
	^ prefix
]

{ #category : #'*Kernel-Extensions' }
UndefinedObject >> with: aValueLink collect: aString [
	^ aValueLink ifNotNil: [ SizeMismatch signal ]
]
