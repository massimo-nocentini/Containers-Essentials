Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials' }
ValueLink >> asLinkedList [

	| list |
	list := LinkedList empty.
	self do: [ :each | list addLast: each ].
	^ list
]

{ #category : #'*Containers-Essentials' }
ValueLink >> do: aBlock [

	^ super do: [ :each | aBlock value: each value ]
]

{ #category : #'*Containers-Essentials' }
ValueLink >> moveToFront: eqBlock ifNone: noneBlock [

	^ super
		  moveToFront: [ :aLink | eqBlock value: aLink value ]
		  ifNone: noneBlock
]

{ #category : #'*Containers-Essentials' }
ValueLink >> nextInteger: n [

	^ (super nextInteger: n) ifNotNil: [ :aValueLink | 
		  aValueLink
			  value: value;
			  yourself ]
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
