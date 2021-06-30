Extension { #name : #ObjectTest }

{ #category : #'*Containers-Essentials-Tests' }
ObjectTest >> testYourselfBlock [

	| var |
	self
		assert: (3 yourself: [ 3 + 4 ]) equals: 3;
		assert: (3 + 4 yourself: [ :seven | seven + 5 ]) equals: 7.

	var := 7.
	self
		assert: (var yourself: [ var := var + 1 ]) equals: 7;
		assert: var equals: 8
]
