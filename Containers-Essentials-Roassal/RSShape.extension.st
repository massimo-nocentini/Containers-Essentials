Extension { #name : 'RSShape' }

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> asCompositeShape [

	^ RSComposite new
		  model: self model;
		  children: (RSGroup new
				   add: self;
				   yourself);
		  yourself
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> boxedWithPad: aPadding [

	^ self padded: aPadding withBoxDo: [ :box | 
		  box
			  color: Color white;
			  borderDo: [ :aBorder | aBorder color: aBorder color translucent ] ]
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> notedWithPad: aPadding [

	^ self padded: aPadding withNoteDo: [ :box | 
		  box
			  color: Color white;
			  borderDo: [ :aBorder | aBorder color: aBorder color translucent ] ]
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> padded: aPadding shape: boxShape do: aBlock [

	| box |
	box := boxShape
		       extent: self extent + (aPadding * 2);
		       cornerRadius: aPadding;
		       yourself.

	aBlock cull: box cull: self.

	RSLocation new
		center;
		stick: box on: self.

	^ RSComposite new
		  shapes: { 
				  box.
				  self };
		  yourself
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> padded: aPadding withBoxDo: aBlock [

	^ self padded: aPadding shape: RSBox new do: aBlock
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> padded: aPadding withNoteDo: aBlock [

	^ self padded: aPadding shape: RSNote new do: aBlock
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> padded: aPadding withSimplerNoteDo: aBlock [

	^ self padded: aPadding shape: RSSimplerNote new do: aBlock
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> paddedWithGoldenRatio [

	| pad |
	pad := self extent * Float silverRatio / 2 in: [ :extent | 
		       extent x max: extent y ].

	^ RSComposite new
		  shapes: { self };
		  padding: pad;
		  yourself
]

{ #category : '*Containers-Essentials-Roassal' }
RSShape >> sameColorAsBorderColor [

	self color: self border color
]
