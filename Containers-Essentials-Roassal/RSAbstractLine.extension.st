Extension { #name : #RSAbstractLine }

{ #category : #'*Containers-Essentials-Roassal' }
RSAbstractLine >> dotted [

	self dashArray: { Float goldenRatio }
]
