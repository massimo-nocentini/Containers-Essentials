Trait {
	#name : #TContainerSet,
	#category : #'dsst-Traits'
}

{ #category : #adding }
TContainerSet >> includes: anObject [
	self explicitRequirement
]

{ #category : #adding }
TContainerSet >> push: anObject [
	self explicitRequirement
]
