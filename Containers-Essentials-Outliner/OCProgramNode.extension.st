Extension { #name : 'OCProgramNode' }

{ #category : '*Containers-Essentials-Outliner' }
OCProgramNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	| text |
	text := codePresenter
		        text: self formattedCode replaceAllTabsWithThreeSpaces;
		        textWithStyle.

	^ text asRSPangoShapeUsingFont:
		  PangoLogicalFontManager pangoMonospace
]

{ #category : '*Containers-Essentials-Outliner' }
OCProgramNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ self
]
