Extension { #name : #Dictionary }

{ #category : #'*Containers-Essentials-Visualizations' }
Dictionary >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection" , { (#keysMap -> [ :anObj | 
	   Array streamContents: [ :aStream | 
		   array withIndexDo: [ :anAssociation :index | 
			   anAssociation ifNotNil: [ 
				   aStream nextPut: anAssociation key -> index ] ] ] ]) }"
]
