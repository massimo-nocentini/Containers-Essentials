Extension { #name : #SortedCollection }

{ #category : #'*Containers-Essentials' }
SortedCollection >> merge: anObject [

	^ anObject mergeSortedCollection: self
]

{ #category : #'*Containers-Essentials' }
SortedCollection >> mergeCollection: aCollection [

	^ (self class sortUsing: self sortBlock)
		  addAll: aCollection;
		  mergeSortedCollection: self
]

{ #category : #'*Containers-Essentials' }
SortedCollection >> mergeSortedCollection: aSortedCollection [

	^ self sortBlock = aSortedCollection sortBlock
		  ifTrue: [ 
			  | anArray |
			  anArray := Array streamContents: [ :aStream | 
				             | myStream itsStream lessThan |
				             lessThan := self sortBlock ifNil: [ #<= ].
				             myStream := self readStream.
				             itsStream := aSortedCollection readStream.
				             [ myStream atEnd or: [ itsStream atEnd ] ] 
					             whileFalse: [ 
						             aStream nextPut:
							             ((lessThan
								               value: myStream peek
								               value: itsStream peek)
								              ifTrue: [ myStream next ]
								              ifFalse: [ itsStream next ]) ].
				             aStream
					             nextPutAll: myStream upToEnd;
					             nextPutAll: itsStream upToEnd ].

			  self class new
				  instVarNamed: #sortBlock put: self sortBlock;
				  instVarNamed: #array put: anArray;
				  instVarNamed: #firstIndex put: 1;
				  instVarNamed: #lastIndex put: anArray size;
				  yourself ]
		  ifFalse: [ DomainError signal ]
]
