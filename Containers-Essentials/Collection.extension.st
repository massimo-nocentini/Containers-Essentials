Extension { #name : #Collection }

{ #category : #'*Containers-Essentials' }
Collection >> adaptToComplex: rcvr andSend: selector [

	"If I am involved in arithmetic with a scalar, return a Collection of
	the results of each element combined with the scalar in that expression."

	^ self collect: [ :element | rcvr perform: selector with: element ]
]

{ #category : #'*Containers-Essentials' }
Collection >> at: aKey update: aBlock [

	^ self at: aKey put: (aBlock value: (self at: aKey))
]

{ #category : #'*Containers-Essentials' }
Collection >> doª: aBlock [

	self do: aBlock
]

{ #category : #'*Containers-Essentials' }
Collection >> select: selectBlock thenFlatCollect: collectBlock [

	^ self class streamContents: [ :aStream | 
		  self
			  select: selectBlock
			  thenDo: [ :each | aStream nextPutAll: collectBlock ! each ] ]
]

{ #category : #'*Containers-Essentials' }
Collection >> withIntegersCollectionDo: aBlock [

	| map collection identities |
	map := Dictionary new.

	identities := IdentityDictionary new.

	collection := Array streamContents: [ :aStream | 
		              self do: [ :each | 
			              | i |
			              i := identities
				                   at: each
				                   ifAbsentPut: [ identities size + 1 ].

			              map
				              at: i
				              ifPresent: [ :anObject | 
				              self assert: anObject == each ]
				              ifAbsentPut: [ each ].

			              aStream nextPut: i ] ].

	^ aBlock value: collection value: map
]
