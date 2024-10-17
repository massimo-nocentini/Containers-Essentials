Extension { #name : 'ASTMessageNode' }

{ #category : '*Containers-Essentials-Outliner' }
ASTMessageNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ (self receiver isVariable and: [ self receiver name = pseudoName ])
		  ifTrue: [ notebook translateRBMessageNode: self ]
		  ifFalse: [ self ]
]
