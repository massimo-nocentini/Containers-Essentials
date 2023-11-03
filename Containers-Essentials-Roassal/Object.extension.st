Extension { #name : 'Object' }

{ #category : '*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker descriptor: descriptor [

	| markup font shape |
	font := self isNumber
		        ifTrue: [ LogicalFont pangoMath ]
		        ifFalse: [ LogicalFont pangoMonospace ].

	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_family="';
			          nextPutAll: font familyName;
			          nextPutAll: '"';
			          nextPutAll: ' foreground="#';
			          nextPutAll: self shStyleElement color asHexString;
			          nextPutAll: '"';
			          nextPutAll: ' font_size="larger">';
			          nextPutAll: self fullPangoPrintString;
			          nextPutAll: '</span>' ].

	shape := markup asRSPangoShapeUsingFont: LogicalFont pangoMonospace.

	^ shape
		  model: self;
		  yourself
]
