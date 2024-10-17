Extension { #name : 'ASTCascadeNode' }

{ #category : '*Containers-Essentials-Outliner' }
ASTCascadeNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ (self receiver isVariable and: [ self receiver name = pseudoName ])
		  ifTrue: [
			  RBSequenceNode statements: (self messages collect: [ :each |
					   each
						   translateForNotebook: notebook
						   pseudoNotebookVariableName: pseudoName ]) ]
		  ifFalse: [ self ]
]
