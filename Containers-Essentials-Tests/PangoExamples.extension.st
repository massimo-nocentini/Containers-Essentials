Extension { #name : #PangoExamples }

{ #category : #'*Containers-Essentials-Tests' }
PangoExamples class >> example8RoassalShape [

	<example>
	RSCanvas new
		add: (RSPangoText new
				 markup: '<span foreground="blue" font_family="Sans">
		<b> bold </b>
		<u> is </u>
		<i> nice </i>
	</span>
	<span foreground="red" font_family="Helvetica"><tt> hello </tt></span>
	 <span foreground="black" font_family="sans" font_stretch="ultracondensed" letter_spacing="500" font_weight="light"> SANS</span><span foreground="#FFCC00"> colored</span>
	';
				 draggable;
				 "notedWithPad: Float goldenRatio"yourself);
		zoomToFit;
		addInteraction: RSCanvasController new;
		"showEncompassingRectangles;"open
]
