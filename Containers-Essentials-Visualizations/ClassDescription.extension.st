Extension { #name : 'ClassDescription' }

{ #category : '*Containers-Essentials-Visualizations' }
ClassDescription >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitClass: self
]

{ #category : '*Containers-Essentials-Visualizations' }
ClassDescription >> asFluidDefinitionShape [
	"I produce a Roassal Pango text with the fluid definition of myself, 
	 according to `FluidClassDefinitionPrinter`."

	| presenter |
	presenter := SpCodePresenter new
		             beForBehavior: self;
		             text:
			             self expandedDefinitionString
				             replaceAllTabsWithThreeSpaces;
		             yourself.

	^ (presenter textWithStyle asRSPangoShapeUsingFont:
			   PangoLogicalFontManager pangoMonospace)
		  model: self;
		  yourself
]
