Extension { #name : 'SpCodePresenter' }

{ #category : '*Containers-Essentials-Visualizations' }
SpCodePresenter >> textWithStyle [

	self asWindow buildWithSpecLayout: self layout.
	^ self adapter textWithStyle
]
