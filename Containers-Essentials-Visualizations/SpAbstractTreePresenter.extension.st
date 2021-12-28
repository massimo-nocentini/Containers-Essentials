Extension { #name : #SpAbstractTreePresenter }

{ #category : #'*Containers-Essentials-Visualizations' }
SpAbstractTreePresenter >> allShownItems [

	^ self withAdapterDo: [ :anAdapter | 
		  anAdapter widget dataSource allShownItems collect: [ :each | 
			  each data ] ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
SpAbstractTreePresenter >> expandAllTo: aDepth [

	"Expand all nodes of the tree. 
	 WARNING: If your tree is big, this operation can be slow."

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter expandAllTo: aDepth ]
]
