Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| markup font styleElement shape |
	self isNumber
		ifTrue: [
			font := LogicalFont pangoMath.
			styleElement := SHStyleElement withTokens: #( number ) ]
		ifFalse: [
			font := LogicalFont pangoMonospace.
			styleElement := self isString
				                ifTrue: [ SHStyleElement withTokens: #( string ) ]
				                ifFalse: [
				                SHStyleElement withTokens: #( default ) ] ].

	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_family="';
			          nextPutAll: font familyName;
			          nextPutAll: '"';
			          nextPutAll: ' foreground="#';
			          nextPutAll: styleElement color asHexString;
			          nextPutAll: '"';
			          nextPutAll: ' font_size="larger">';
			          nextPutAll: self fullPangoPrintString;
			          nextPutAll: '</span>' ].

	shape := markup asRSPangoShapeUsingFont:
		         LogicalFont pangoMonospace.

	^ shape
		  model: self;
		  yourself
]
