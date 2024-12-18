Extension { #name : 'FileReference' }

{ #category : '*Containers-Essentials' }
FileReference >> asTreeString [

	^ String streamContents: [ :s |
		  LibC uniqueInstance pipe: 'tree ' , self fullName writeStream: s ]
]
