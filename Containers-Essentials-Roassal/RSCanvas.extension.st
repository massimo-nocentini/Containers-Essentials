Extension { #name : 'RSCanvas' }

{ #category : '*Containers-Essentials-Roassal' }
RSCanvas >> inspectorCanvas [
	"A presenter showing me, made without a presenter builder. Pharo 13 and later show no tab of an inspection method that takes no builder (only the warning 'Inspections made without presenter builder are no longer supported'), so a tab ends with Roassal's inspectorCanvas: aBuilder instead, as those of this repository do; I am left for code that is not an inspection method."

	^ SpRoassalInspectorPresenter new
		  canvas: self;
		  yourself
]
