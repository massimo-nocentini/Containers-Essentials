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
	"Yields the `#asString` representation in a Pango text shape.

A list:
- This is a point
  - this another <span foreground='red'>hello</span>
    over two lines
- again at top level 
   over two lines. The following is a complete math block:
   
$$
	<span font_size='larger'>&#8747;</span><span rise='-5pt' font_size='smaller'>1</span><span rise='5pt' font_size='smaller'>\infty</span> x dx
$$

Perhaps this $a = 1, \forall &#0945; \elementof N \thereexists$ should be some mathy expression.

"

	^ self asString fixEmptyLinesForPango asText asRSPangoTextUsingFont:
		  (LogicalFont fontconfigPharoSansPointSize:
			   StandardFonts defaultFont pointSize)
]
