Extension { #name : #HashedCollection }

{ #category : #'*Collections-Abstract-Visualizations' }
HashedCollection >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { (#keysMap -> [ :anObj | 
	   Array streamContents: [ :aStream | 
		   array withIndexDo: [ :anAssociation :index | 
			   anAssociation ifNotNil: [ 
				   aStream nextPut: anAssociation key -> index ] ] ] ]) }
]
