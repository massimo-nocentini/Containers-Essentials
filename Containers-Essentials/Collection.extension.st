Extension { #name : #Collection }

{ #category : #'*Containers-Essentials' }
Collection >> adaptToComplex: rcvr andSend: selector [

	"If I am involved in arithmetic with a scalar, return a Collection of
	the results of each element combined with the scalar in that expression."

	^ self collect: [ :element | rcvr perform: selector with: element ]
]

{ #category : #'*Containers-Essentials' }
Collection >> merge: anObject [

	^ anObject mergeCollection: self
]

{ #category : #'*Containers-Essentials' }
Collection >> mergeCollection: aCollection [

	self subclassResponsibility
]

{ #category : #'*Containers-Essentials' }
Collection >> mergeSortedCollection: aSortedCollection [

	^ aSortedCollection mergeCollection: self
]

{ #category : #'*Containers-Essentials' }
Collection >> select: selectBlock thenFlatCollect: collectBlock [

	^ (self select: selectBlock) flatCollect: collectBlock
]
