Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Roassal' }
Object >> asDefaultShapeForWalker: aWalker [

	| markup |
	markup := String streamContents: [ :aStream |
		          aStream
			          nextPutAll:
				          '<span font_family="Neo Euler" font_stretch="condensed" font_size="larger">';
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
