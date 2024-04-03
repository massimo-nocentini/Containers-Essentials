Extension { #name : 'IceRepository' }

{ #category : '*Containers-Essentials' }
IceRepository class >> atPackage: package ifAbsent: block [

	^ self registry
		  detect: [ :each | each includesPackageNamed: package name ]
		  ifNone: block
]
