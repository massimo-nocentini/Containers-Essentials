Extension { #name : #SpCodePresenter }

{ #category : #'*Containers-Essentials' }
SpCodePresenter >> textWithStyle [

	self asWindow buildWithSpecLayout: self layout.
	^ self adapter textWithStyle
]
