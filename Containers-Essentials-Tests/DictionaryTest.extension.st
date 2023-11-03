Extension { #name : 'DictionaryTest' }

{ #category : '*Containers-Essentials-Tests' }
DictionaryTest >> testAnyAssociation [

	self
		should: [ Dictionary new anyAssociation ]
		raise: CollectionIsEmpty.

	self
		assert: (Dictionary new
				 at: 0 put: 1;
				 anyAssociation)
		equals: 0 -> 1.

	self
		assert: (Dictionary new
				 at: 0 put: 1;
				 at: 1 put: 2;
				 anyAssociation)
		equals: 0 -> 1.

	self
		assert: (Dictionary new
				 at: 0 put: 1;
				 at: 1 put: 2;
				 select: #even) anyAssociation
		equals: 1 -> 2
]
