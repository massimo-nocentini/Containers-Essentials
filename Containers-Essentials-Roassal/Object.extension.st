Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| markup fontFamily textColor |
	fontFamily := self isNumber
		              ifTrue: [ 'Neo Euler' ]
		              ifFalse: [ 'Source Code Pro' ].

	textColor := self isNumber | self isString | self isNil
		             ifTrue: [
			             | attributes |
			             attributes := (SpCodePresenter new
				                            beForScripting;
				                            text: self fullPrintString;
				                            textWithStyle) attributesAt: 1.

			             attributes
				             detect: [ :attr | attr isMemberOf: TextColor ]
				             ifNone: [ nil ] ]
		             ifFalse: [ nil ].

	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll: '<span font_family="';
			          nextPutAll: fontFamily;
			          nextPutAll: '"'.

		          textColor ifNotNil: [
			          aStream
				          nextPutAll: ' foreground="#';
				          nextPutAll: textColor color asHexString;
				          nextPutAll: '"' ].

		          aStream
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
