Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> byteAt: d update: aBlock [
	^ self byteAt: d put: (aBlock value: (self byteAt: d))
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copyRightChunkInto: aByteArray byte: byte lastByte: lastByte shift: bitShift len: len [
	| lshift sb s d |
	lshift := 8 - bitShift.
	sb := self byteAt: byte.
	s := byte + 1.
	d := 1.
	[ d = lastByte ]
		whileFalse: [ | sbnext b |
			sbnext := self byteAt: s.
			b := (BitArray bitShift: sbnext left: lshift) bitAnd: 16rff.
			aByteArray byteAt: d put: (sb >> bitShift bitOr: b).
			sb := sbnext.
			s := s + 1.
			d := d + 1 ].
	aByteArray
		byteAt: d
		update: [ :l | 
			| left r |
			left := (BitArray wmask7: len - 1) + 1.
			r := sb >> bitShift.
			left <= lshift
				ifFalse: [ r := r bitOr: (BitArray bitShift: (self byteAt: s) left: lshift) ].
			BitArray fit: left + 1 left: l right: r ]
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copyRightChunkInto: aByteArray shift: shft len: len [
	| byte bitShift lastByte |
	byte := (BitArray byteOf: shft) + 1.
	bitShift := BitArray wmask7: shft.
	lastByte := (BitArray byteOf: len - 1) + 1.
	^ bitShift
		ifZero: [ self
				copybits: aByteArray
				byte: lastByte
				len: len
				assoc: byte -> 1 ]
		ifNotZero: [ self
				copyRightChunkInto: aByteArray
				byte: byte
				lastByte: lastByte
				shift: bitShift
				len: len ]
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copybits: aByteArray [
	^ aByteArray
		replaceFrom: 1
		to: self size
		with: self
		startingAt: 1
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copybits: aByteArray byte: lastByte len: len assoc: anAssociation [
	| s d byte |
	s := anAssociation key.
	d := anAssociation value.
	[ d = lastByte ]
		whileFalse: [ aByteArray byteAt: d put: (self byteAt: s).
			s := s + 1.
			d := d + 1 ].
	byte := self byteAt: s.
	aByteArray
		byteAt: d
		put:
			((BitArray wmask7: len)
				ifZero: [ byte ]
				ifNotZero:
					[ :lft | BitArray fit: lft + 1 left: (aByteArray byteAt: d) right: byte ])
]
