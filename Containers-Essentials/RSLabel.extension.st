Extension { #name : #RSLabel }

{ #category : #'*Containers-Essentials' }
RSLabel >> withText: aText do: aBlock [

	| backup value |
	backup := self text.

	self text: aText.

	value := aBlock cull: self.

	self text: backup.

	^ value
]
