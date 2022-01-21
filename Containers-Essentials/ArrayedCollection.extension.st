Extension { #name : #ArrayedCollection }

{ #category : #'*Containers-Essentials' }
ArrayedCollection >> countingSort: key maximum: k [
	| count output |
	count := self class new: k + 1 withAll: 0.
	self do: [ :each | count at: (key value: each) + 1 incrementBy: 1 ].
	count := count scan: [ :acc :each | acc + each ] init: 1.
	output := self class new: self size.
	self
		do: [ :each | 
			| i |
			i := (key value: each) + 1.
			output at: (count at: i) put: each.
			count at: i incrementBy: 1 ].
	^ output
]
