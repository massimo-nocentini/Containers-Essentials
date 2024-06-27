Extension { #name : 'RBProgramNode' }

{ #category : '*Containers-Essentials-Outliner' }
RBProgramNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	| text |
	text := codePresenter
		        text: self formattedCode replaceAllTabsWithThreeSpaces;
		        textWithStyle.

	^ text asRSPangoShapeUsingFont:
		  PangoLogicalFontManager pangoMonospace
]

{ #category : '*Containers-Essentials-Outliner' }
RBProgramNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ self
]
