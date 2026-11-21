Extension { #name : 'SHRBTextStyler' }

{ #category : '*Containers-Essentials-Roassal' }
SHRBTextStyler class >> colorFor: aToken [
	"The color that the current style table gives to aToken (#default, #number, #selector, ...), black when it gives none. Pharo 15 has no SHStyleElement class>>#withTokens: any more."

	^ (self attributesFor: aToken)
		  detect: [ :each | each isKindOf: TextColor ]
		  ifFound: [ :each | each color ]
		  ifNone: [ Color black ]
]
