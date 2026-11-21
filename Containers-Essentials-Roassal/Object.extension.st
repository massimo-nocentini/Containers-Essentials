Extension { #name : 'Object' }

{ #category : '*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| markup |
	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_size="larger" foreground="#';
			          nextPutAll:
				          (SHRBTextStyler colorFor: self shoutStyleToken) asHexString;
			          nextPutAll: '">';
			          nextPutAll: self fullPangoPrintString;
			          nextPutAll: '</span>' ].

	^ RSPangoMarkup new
		  model: self;
		  font: self defaultPangoFont;
		  text: markup;
		  yourself
]

{ #category : '*Containers-Essentials-Roassal' }
Object >> shoutStyleToken [
	"The token of the Shout style table whose color my shapes use for me."

	^ #default
]
