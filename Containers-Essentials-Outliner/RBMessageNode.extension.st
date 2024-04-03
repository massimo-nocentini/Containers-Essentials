Extension { #name : 'RBMessageNode' }

{ #category : '*Containers-Essentials-Outliner' }
RBMessageNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ (self receiver isVariable and: [ self receiver name = pseudoName ])
		  ifTrue: [ notebook translateRBMessageNode: self ]
		  ifFalse: [ self ]
]
