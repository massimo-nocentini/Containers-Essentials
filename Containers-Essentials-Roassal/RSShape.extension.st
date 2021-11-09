Extension { #name : #RSShape }

{ #category : #'*Containers-Essentials-Roassal' }
RSShape >> paddedWithGoldenRatio [

	| pad |
	pad := self extent * Float silverRatio / 2 in: [ :extent | 
		       extent x max: extent y ].

	^ RSComposite new
		  shapes: { self };
		  padding: pad;
		  yourself
]

{ #category : #'*Containers-Essentials-Roassal' }
RSShape >> sameColorAsBorderColor [

	self color: self border color
]
