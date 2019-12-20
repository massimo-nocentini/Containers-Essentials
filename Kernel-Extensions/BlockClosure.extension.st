Extension { #name : #BlockClosure }

{ #category : #'*Kernel-Extensions' }
BlockClosure >> !! args [
	^ self valueWithArguments: args
]
