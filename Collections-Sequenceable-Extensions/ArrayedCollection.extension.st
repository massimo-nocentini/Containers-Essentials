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
