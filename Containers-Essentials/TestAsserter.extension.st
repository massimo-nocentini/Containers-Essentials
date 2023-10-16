Extension { #name : 'TestAsserter' }

{ #category : '*Containers-Essentials' }
TestAsserter >> assert: actual and: another equals: expected [

	^ self
		  assert: actual equals: expected;
		  assert: another equals: expected;
		  assert: actual equals: another
]
