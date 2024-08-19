Extension { #name : 'ASTProgramNode' }

{ #category : '*Containers-Essentials-Outliner' }
ASTProgramNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	| text |
	text := codePresenter
		        text: self formattedCode replaceAllTabsWithThreeSpaces;
		        textWithStyle.

	^ text asRSPangoShapeUsingFont:
		  PangoLogicalFontManager pangoMonospace
]

{ #category : '*Containers-Essentials-Outliner' }
ASTProgramNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ self
]
