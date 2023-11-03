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
RSShape >> sameColorAsBorderColor [

	self color: self border color
]
