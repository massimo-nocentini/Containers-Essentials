Extension { #name : 'Package' }

{ #category : '*Containers-Essentials' }
Package >> testSuiteFromAllSelectors [

	| suite |
	suite := TestSuite named: self packageName.
	suite addTests:
		((self classes select: #isTestCase) flatCollect: [ :aTestClass | 
			 aTestClass buildSuiteFromAllSelectors tests ]).

	^ suite
]
