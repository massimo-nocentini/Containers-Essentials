Extension { #name : #RBMessageNode }

{ #category : #'*Containers-Essentials-Outliner' }
RBMessageNode >> translateForNotebook: notebook [

	^ (self receiver isVariable and: [
		   self receiver name = #thisNotebook ])
		  ifTrue: [ notebook translateRBMessageNode: self ]
		  ifFalse: [ self ]
]
