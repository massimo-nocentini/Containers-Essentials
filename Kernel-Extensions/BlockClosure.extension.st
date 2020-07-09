Extension { #name : #BlockClosure }

{ #category : #'*Kernel-Extensions' }
BlockClosure >> !! args [
	^ self valueWithArguments: args
]

{ #category : #'*Kernel-Extensions' }
BlockClosure >> , aBlock [
	aBlock numArgs = 1
		ifTrue: [ ^ [ :a | self valueWithArguments: (aBlock value: a) ] ].
	aBlock numArgs = 2
		ifTrue: [ ^ [ :a :b | self valueWithArguments: (aBlock value: a value: b) ] ].
	aBlock numArgs = 3
		ifTrue: [ ^ [ :a :b :c | self valueWithArguments: (aBlock value: a value: b value: c) ] ].
	aBlock numArgs = 4
		ifTrue: [ ^ [ :a :b :c :d | 
			self
				valueWithArguments:
					(aBlock
						value: a
						value: b
						value: c
						value: d) ] ]
]
