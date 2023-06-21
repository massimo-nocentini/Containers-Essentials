Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| markup fontFamily styleElement |
	fontFamily := self isNumber
		              ifTrue: [ 'Neo Euler' ]
		              ifFalse: [ 'Source Code Pro' ].

	styleElement := self isNumber
		                ifTrue: [ SHStyleElement withTokens: #( number ) ]
		                ifFalse: [
			                self isString
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

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asStringPangoText [
	"Yields the `#asString` representation in a Pango text shape."

	^ self asString fixEmptyLinesForPango asText asRSPangoTextUsingFont:
		  (LogicalFont fontconfigPharoSansPointSize:
			   StandardFonts defaultFont pointSize)
]
