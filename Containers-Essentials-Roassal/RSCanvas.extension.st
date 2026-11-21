Extension { #name : 'RSCanvas' }

{ #category : '*Containers-Essentials-Roassal' }
RSCanvas >> inspectorCanvas [
	"The presenter of an inspector tab showing me, for the inspector methods that take no builder. Roassal has only inspectorCanvas: aBuilder now, which is itself a tab."

	^ SpRoassalInspectorPresenter new
		  canvas: self;
		  yourself
]
