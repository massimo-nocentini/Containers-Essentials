Extension { #name : #RSShape }

{ #category : #'*Containers-Essentials-Roassal' }
RSShape >> boxedWithPad: aPadding [

	| box |
	box := RSBox new
		       extent: self extent + (aPadding * 2);
		       cornerRadius: aPadding;
		       color: Color white;
		       borderDo: [ :aBorder | 
			       aBorder color: aBorder color translucent ];
		       yourself.

	RSLocation new
		center;
		stick: box on: self.

	^ RSComposite new
		  shapes: { 
				  box.
				  self };
		  yourself
]

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
