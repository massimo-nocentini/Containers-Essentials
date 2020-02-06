Extension { #name : #ByteArray }

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> bits [
	| bits |
	bits := Array new: self size * 8.
	0 to: self size - 1 do: [ :i | 
		| byte |
		byte := self byteAt: i + 1.
		bits replaceFrom: i * 8 + 1 to: (i + 1) * 8 with: byte eightBits ].
	^ bits
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> byteAt: d update: aBlock [
	^ self byteAt: d put: (aBlock value: (self byteAt: d))
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copyLeftChunkInto: aByteArray byte: byte lastByte: lastByte shift: bitShift len: len [
	| rshift sb d s |
	rshift := 8 - bitShift.
	sb := self byteAt: 1.
	aByteArray
		byteAt: byte
		update: [ :r | 
			BitArray
				fit: bitShift + 1
				left: (BitArray bitShift: sb left: bitShift)
				right: r ].

	"Loop."
	d := byte + 1.
	s := 2.
	[ d = lastByte ]
		whileFalse: [ | sbnext b |
			sbnext := self byteAt: s.
			b := (BitArray bitShift: sbnext left: bitShift) bitAnd: 16rff.
			aByteArray byteAt: d put: (sb >> rshift bitOr: b).
			sb := sbnext.
			d := d + 1.
			s := s + 1 ].
	aByteArray
		byteAt: d
		update: [ :l | 
			| left r |
			left := (BitArray wmask7: bitShift + len - 1) + 1.
			r := sb >> rshift.
			left <= bitShift
				ifFalse: [ r := r bitOr: (BitArray bitShift: (self byteAt: s) left: bitShift) ].
			BitArray fit: left + 1 left: l right: r ]
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copyLeftChunkInto: aByteArray shift: shft len: len [
	len
		ifNotZero: [ | byte bitShift lastByte |
			byte := (BitArray byteOf: shft) + 1.
			bitShift := BitArray wmask7: shft.
			lastByte := (BitArray byteOf: shft + len - 1) + 1.
			bitShift
				ifZero: [ self
						copybits: aByteArray
						byte: lastByte
						len: len
						assoc: 1 -> byte ]
				ifNotZero: [ lastByte = byte
						ifTrue: [ | s d l mask sb db |
							s := 1.
							d := byte.
							l := len.
							mask := BitArray
								bitShift: (BitArray lobits: l + 1)
								left: bitShift.
							sb := (BitArray bitShift: (self byteAt: s) left: bitShift)
								bitAnd: mask.
							db := (aByteArray byteAt: d) bitAnd: mask bitInvert8.
							aByteArray byteAt: d put: (sb bitOr: db) ]
						ifFalse: [ self
								copyLeftChunkInto: aByteArray
								byte: byte
								lastByte: lastByte
								shift: bitShift
								len: len ] ] ]
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> copyRightChunkInto: aByteArray byte: byte lastByte: lastByte shift: bitShift len: len [
	| lshift sb d |
	lshift := 8 - bitShift.
	sb := self byteAt: byte.
	d := 1.
	[ d = lastByte ]
		whileFalse: [ | sbnext b |
			sbnext := self byteAt: byte + d.
			b := (BitArray bitShift: sbnext left: lshift) bitAnd: 16rff.
			aByteArray byteAt: d put: (sb >> bitShift bitOr: b).
			sb := sbnext.
			d := d + 1 ].
	aByteArray
		byteAt: d
		update: [ :l | 
			| left r |
			left := (BitArray wmask7: len - 1) + 1.
			r := sb >> bitShift.
			left <= lshift
				ifFalse: [ r := r
						bitOr: (BitArray bitShift: (self byteAt: byte + d) left: lshift) ].
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

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> flip: aByteArray len: nbits [
	| size |
	size := self size.
	1 to: size do: [ :i | aByteArray byteAt: i put: (self byteAt: i) bitInvert8 ].
	(BitArray wmask7: nbits)
		ifNotZero: [ :left | 
			aByteArray
				byteAt: size
				put: ((self byteAt: size) bitInvert8 bitAnd: (BitArray lobits: left + 1)) ]
]

{ #category : #'*Collections-Native-BitArray' }
ByteArray >> trim: len [
	(BitArray wmask7: len)
		ifNotZero: [ :lft | 
			self
				byteAt: self size
				update: [ :byte | byte bitAnd: (BitArray lobits: lft + 1) ] ]
]
