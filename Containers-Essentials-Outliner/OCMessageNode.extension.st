Extension { #name : 'OCMessageNode' }

{ #category : '*Containers-Essentials-Outliner' }
OCMessageNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ (self receiver isVariable and: [ self receiver name = pseudoName ])
		  ifTrue: [ notebook translateRBMessageNode: self ]
		  ifFalse: [ self ]
]
