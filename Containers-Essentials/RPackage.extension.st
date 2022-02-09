Extension { #name : #RPackage }

{ #category : #'*Containers-Essentials' }
RPackage >> testSuiteFromAllSelectors [

	| suite |
	suite := TestSuite named: self packageName.
	suite addTests:
		((self classes select: #isTestCase) flatCollect: [ :aTestClass | 
			 aTestClass buildSuiteFromAllSelectors tests ]).

	^ suite
]
