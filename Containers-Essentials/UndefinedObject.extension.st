Extension { #name : #UndefinedObject }

{ #category : #'*Containers-Essentials' }
UndefinedObject >> do: aFullBlockClosure [

	
]

{ #category : #'*Containers-Essentials' }
UndefinedObject >> with: aValueLink collect: aString [

	^ self
		  with: aValueLink
		  collect: aString
		  onSizeMismatchDo: [ SizeMismatch signal ]
]

{ #category : #'*Containers-Essentials' }
UndefinedObject >> with: aValueLink collect: aBlock onSizeMismatchDo: eBlock [

	^ aValueLink ifNotNil: [ 
		  self
			  withValueLink: aValueLink
			  collect: aBlock
			  onSizeMismatchDo: eBlock ]
]

{ #category : #'*Containers-Essentials' }
UndefinedObject >> withValueLink: aValueLink collect: aString onSizeMismatchDo: eBlock [

	^ aValueLink ifNotNil: [ eBlock cull: aValueLink ]
]
