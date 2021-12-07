Extension { #name : #SpAbstractTreePresenter }

{ #category : #'*Containers-Essentials-Visualizations' }
SpAbstractTreePresenter >> allShownItems [

	^ self withAdapterDo: [ :anAdapter | 
		  anAdapter widget dataSource allShownItems collect: [ :each | 
			  each data ] ]
]
