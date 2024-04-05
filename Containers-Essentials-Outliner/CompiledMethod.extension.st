Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Outliner' }
CompiledMethod >> asNotebook [

	| presenter notebook pseudoVariableName |
	presenter := SpCodePresenter new
		             beForScripting;
		             yourself.

	pseudoVariableName := self sourceNode arguments
		                      ifEmpty: [ '_' "a dummy name" ]
		                      ifNotEmpty: [ :args | args first name ].

	notebook := CTNotebookKeyedValuedOrderedCollection new
		            pseudoVariableName: pseudoVariableName;
		            yourself.

	presenter interactionModel addBinding:
		(WorkspaceVariable key: pseudoVariableName value: notebook).


	presenter text:
		(RBParser parseExpression: self sourceNode body formattedCode)
			formattedCode.

	notebook codePresenter: presenter.

	notebook value.

	^ notebook
]

{ #category : '*Containers-Essentials-Outliner' }
CompiledMethod >> docString [

	^ String cr , String cr join: (self ast comments collect: [ :each |
			   each sourceCode allButFirstAndLast ])
]
