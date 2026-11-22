"
I test the post-load actions of BaselineOfContainersEssentials, which upgrade an image that had the sequence diagrams in Containers-Essentials-UML.
"
Class {
	#name : 'BaselineOfContainersEssentialsTest',
	#superclass : 'TestCase',
	#category : 'Containers-Essentials-Tests-Tests',
	#package : 'Containers-Essentials-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
BaselineOfContainersEssentialsTest >> testPostLoadRemovesTheEmptyUMLPackage [

	| name |
	name := 'Containers-Essentials-UML'.
	self deny: (PackageOrganizer default hasPackage: name).
	[
	PackageOrganizer default ensurePackage: name.
	MCWorkingCopy forPackage: (MCPackage named: name).

	BaselineOfContainersEssentials new postLoadAfterUMLMove.

	self
		deny: (PackageOrganizer default hasPackage: name);
		deny: (MCWorkingCopy hasPackageNamed: name) ] ensure: [
		(PackageOrganizer default packageNamed: name ifAbsent: [ nil ])
			ifNotNil: [ :package | package removeFromSystem ].
		(MCWorkingCopy hasPackageNamed: name) ifTrue: [
			(MCWorkingCopy forPackageNamed: name) unregister ] ]
]
