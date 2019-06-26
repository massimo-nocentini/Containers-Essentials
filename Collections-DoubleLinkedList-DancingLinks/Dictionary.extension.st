Extension { #name : #Dictionary }

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
Dictionary >> context: k with: v enter: inBlock do: doBlock exit: outBlock [
	| w z |
	w := inBlock value.
	self at: k put: v.
	z := doBlock cull: w.
^	outBlock cull: (self removeKey: k) cull: z
]

{ #category : #'*Collections-DoubleLinkedList-DancingLinks' }
Dictionary >> with: anAssociation enter: inBlock do: doBlock exit: outBlock [
	| k v w z |
	k := anAssociation key.
	v := anAssociation value.
	w := inBlock value.
	self at: k put: v.
	z := doBlock cull: w.
	 outBlock cull: (self removeKey: k) cull: z.
	^ z
]
