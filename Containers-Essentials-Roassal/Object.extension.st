Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| markup fontFamily styleElement |
	self isNumber
		ifTrue: [
			fontFamily := 'Neo Euler'.
			styleElement := SHStyleElement withTokens: #( number ) ]
		ifFalse: [
			fontFamily := 'Source Code Pro'.
			styleElement := self isString
				                ifTrue: [ SHStyleElement withTokens: #( string ) ]
				                ifFalse: [
				                SHStyleElement withTokens: #( default ) ] ].

	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_family="';
			          nextPutAll: fontFamily;
			          nextPutAll: '"';
			          nextPutAll: ' foreground="#';
			          nextPutAll: styleElement color asHexString;
			          nextPutAll: '"';
			          nextPutAll: ' font_size="larger">';
			          nextPutAll: self fullPangoPrintString;
			          nextPutAll: '</span>' ].

	^ markup asRSPangoMarkupUsingFont:
		  (LogicalFont fontconfigPharoMonospacePointSize:
			   StandardFonts defaultFont pointSize)
]
