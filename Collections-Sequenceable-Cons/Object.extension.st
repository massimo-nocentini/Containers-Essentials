Extension { #name : #Object }

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> asCons [
	^ Cons fromObject: self
]

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> asConsWithCdr: aCdr [
	^ Cons fromObject: self lastCdr: aCdr
]

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> consedObject: car [
	^ Cons car: car  cdr: self 
]

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> equalCons: aCons [
	^ false
]

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> ifCons: cBlock ifNotCons: ncBlock [
	^ ncBlock cull: self
]

{ #category : #'*Collections-Sequenceable-Cons' }
Object >> isAtom [

	^ true
]
