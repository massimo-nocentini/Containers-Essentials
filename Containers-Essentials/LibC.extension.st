Extension { #name : 'LibC' }

{ #category : '*Containers-Essentials' }
LibC >> pipe: cmd writeStream: s [

	| file last |
	file := self pipe: cmd mode: 'r'.
	[
	[
	last := (self fgetc: file) value.
	last = 16rFFFFFFFF ] whileFalse: [
		s nextPut: (Character value: last) ] ] ensure: [
		self pipeClose: file ].

	^ s
]
