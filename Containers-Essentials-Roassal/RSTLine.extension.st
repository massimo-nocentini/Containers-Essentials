Extension { #name : #RSTLine }

{ #category : #'*Containers-Essentials-Roassal' }
RSTLine >> dotted [

	self dashArray: { Float goldenRatio }
]
