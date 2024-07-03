Extension { #name : 'Object' }

{ #category : '*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| markup |
	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_size="larger" foreground="#';
			          nextPutAll: self shStyleElement color asHexString;
			          nextPutAll: '">';
			          nextPutAll: self fullPangoPrintString;
			          nextPutAll: '</span>' ].

	^ RSPangoMarkup new
		  model: self;
		  font: self defaultPangoFont;
		  text: markup;
		  yourself
]
