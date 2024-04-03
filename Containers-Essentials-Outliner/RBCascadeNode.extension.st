Extension { #name : 'RBCascadeNode' }

{ #category : '*Containers-Essentials-Outliner' }
RBCascadeNode >> translateForNotebook: notebook pseudoNotebookVariableName: pseudoName [

	^ (self receiver isVariable and: [ self receiver name = pseudoName ])
		  ifTrue: [
			  RBSequenceNode statements: (self messages collect: [ :each |
					   each
						   translateForNotebook: notebook
						   pseudoNotebookVariableName: pseudoName ]) ]
		  ifFalse: [ self ]
]
