Extension { #name : #TestAsserter }

{ #category : #'*Containers-Essentials' }
TestAsserter >> assert: actual and: another equals: expected [

	^ self
		  assert: actual equals: another;
		  assert: another equals: expected
]
