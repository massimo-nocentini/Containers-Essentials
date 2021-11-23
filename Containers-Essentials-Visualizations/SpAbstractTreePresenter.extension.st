Extension { #name : #SpAbstractTreePresenter }

{ #category : #'*Containers-Essentials-Visualizations' }
SpAbstractTreePresenter >> allShownItems [

	^ self adapter widget dataSource allShownItems collect: [ :each | 
		  each data ]
]
