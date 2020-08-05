Extension { #name : #RSEdgeBuilder }

{ #category : #'*Collections-Unordered-Graph-Visualizations' }
RSEdgeBuilder >> source: objects connectFrom: fromblock withModelTo: toBlock [
	| tuples allObjects |
	self
		assert: [ objects notNil ]
		description: 'Cannot provide a nil value as the source'.
	self
		assert: [ objects isCollection ]
		description: 'Need to provide a collection as the source'.
	allObjects := Set new.
	tuples := objects
		collect: [ :o | 
			| f t |
			f := fromblock rtValue: o.
			t := toBlock rtValue: o.
			allObjects
				add: f;
				add: t.
			Array with: f -> t with: o ].
	self objects: allObjects asArray.
	^ self useAssociationModelTuples: tuples
]
