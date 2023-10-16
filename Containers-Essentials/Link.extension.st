Extension { #name : 'Link' }

{ #category : '*Containers-Essentials' }
Link >> asArray [

	| array size i |
	size := self size.

	array := Array new: size.

	i := 0.
	self do: [ :each | 
		i := i + 1.
		array at: i put: each ].

	^ array
]

{ #category : '*Containers-Essentials' }
Link >> do: aBlock [

	| link |
	link := self.
	[ link ] whileNotNil: [ 
		aBlock value: link.
		link := link nextLink.
		link == self ifTrue: [ link := nil ] ]
]

{ #category : '*Containers-Essentials' }
Link >> last [

	| last |
	last := self.

	[ last nextLink ] whileNotNil: [ last := last nextLink ].

	^ last
]

{ #category : '*Containers-Essentials' }
Link >> moveToFront: eqBlock [

	^ self moveToFront: eqBlock ifNone: [ self ]
]

{ #category : '*Containers-Essentials' }
Link >> moveToFront: eqBlock ifNone: noneBlock [

	^ (eqBlock value: self)
		  ifTrue: [ self ]
		  ifFalse: [ 
			  | p pNext |
			  p := self.

			  [ 
			  pNext := p nextLink.
			  pNext isNotNil and: [ (eqBlock value: pNext) not ] ] whileTrue: [ 
				  p := pNext ].

			  pNext ifNil: noneBlock ifNotNil: [ 
				  | tmp ret |
				  tmp := self.
				  ret := pNext.
				  p nextLink: pNext nextLink.
				  ret nextLink: tmp.

				  ret ] ]
]

{ #category : '*Containers-Essentials' }
Link >> next: anObject [

	^ anObject nextFromLink: self
]

{ #category : '*Containers-Essentials' }
Link >> nextFromLink: aLink [

	^ aLink nextLink: self
]

{ #category : '*Containers-Essentials' }
Link >> nextInteger: n [

	^ n = 0
		  ifTrue: [ nil ]
		  ifFalse: [ self class nextLink: (nextLink nextInteger: n - 1) ]
]

{ #category : '*Containers-Essentials' }
Link >> reversed [

	^ self reversed: nil
]

{ #category : '*Containers-Essentials' }
Link >> reversed: aSuffix [

	^ self nextLink reversed: (self copy
			   nextLink: aSuffix;
			   yourself)
]

{ #category : '*Containers-Essentials' }
Link >> size [

	| size nl |
	size := 1.
	nl := self.
	[ nl := nl nextLink ] whileNotNil: [ size := size + 1 ].
	^ size
]

{ #category : '*Containers-Essentials' }
Link >> sizeBlock: aBlock [

	| size nl |
	size := 1.
	nl := self.
	[ nl := aBlock value: nl ] whileNotNil: [ size := size + 1 ].
	^ size
]

{ #category : '*Containers-Essentials' }
Link >> with: aValueLink collect: aBlock [

	^ self
		  with: aValueLink
		  collect: aBlock
		  onSizeMismatchDo: [ SizeMismatch signal ]
]

{ #category : '*Containers-Essentials' }
Link >> with: aValueLink collect: aBlock onSizeMismatchDo: eBlock [

	^ aValueLink ifNil: [ eBlock cull: self ] ifNotNil: [ 
		  self
			  withValueLink: aValueLink
			  collect: aBlock
			  onSizeMismatchDo: eBlock ]
]

{ #category : '*Containers-Essentials' }
Link >> withValueLink: aValueLink collect: aBlock onSizeMismatchDo: eBlock [

	| links |
	links := self nextLink
		         withValueLink: aValueLink nextLink
		         collect: aBlock
		         onSizeMismatchDo: eBlock.

	^ (aBlock value: self value: aValueLink)
		  nextLink: links;
		  yourself
]
