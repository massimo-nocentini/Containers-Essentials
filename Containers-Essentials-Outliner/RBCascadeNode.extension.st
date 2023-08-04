Extension { #name : #RBCascadeNode }

{ #category : #'*Containers-Essentials-Outliner' }
RBCascadeNode >> translateForNotebook: notebook [

	^ (self receiver isVariable and: [
		   self receiver name = #thisNotebook ])
		  ifTrue: [
			  RBSequenceNode statements:
				  (self messages collect: [ :each |
					   each translateForNotebook: notebook ]) ]
		  ifFalse: [ self ]
]
