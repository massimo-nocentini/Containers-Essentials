Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials' }
ValueLink >> asLinkedList [
	| list |
	list := LinkedList empty.
	self do: [ :each | list addLast: each value ].
	^ list
]

{ #category : #'*Containers-Essentials' }
ValueLink >> do: aBlock [

	^ super do: [ :each | aBlock value: each value ]
]

{ #category : #'*Containers-Essentials' }
ValueLink >> with: aValueLink collect: aBlock onSizeMismatchDo: eBlock [

	^ super
		  with: aValueLink
		  collect: [ :aLink :anotherLink | 
			  | v |
			  v := aBlock value: aLink value value: anotherLink value.

			  self class new
				  value: v;
				  yourself ]
		  onSizeMismatchDo: eBlock
]
