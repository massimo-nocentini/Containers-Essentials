Extension { #name : #ArrayedCollection }

{ #category : #'*Collections-Sequenceable-Extensions' }
ArrayedCollection >> bisect: mergeBlock baseBlock: baseBlock [
	^ self
		bisect: mergeBlock
		from: 1
		to: self size
		baseBlock: baseBlock
]

{ #category : #'*Collections-Sequenceable-Extensions' }
ArrayedCollection >> bisect: mergeBlock from: low to: high baseBlock: baseBlock [
	| diff |
	diff := high - low.
	^ diff = 0
		ifTrue: [ baseBlock value: (self at: high)	"Because `high` equals `low`." ]
		ifFalse: [ | middle left right |
			middle := diff // 2 + low.
			left := self
				bisect: mergeBlock
				from: low
				to: middle
				baseBlock: baseBlock.
			right := self
				bisect: mergeBlock
				from: middle + 1
				to: high
				baseBlock: baseBlock.
			mergeBlock value: left value: right ]
]

{ #category : #'*Collections-Sequenceable-Extensions' }
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
