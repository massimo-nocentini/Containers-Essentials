Extension { #name : #PangoExamples }

{ #category : #'*Containers-Essentials-Gtk' }
PangoExamples class >> example8RoassalShape [

	<example>
	| pangoText |
	pangoText := RSPangoText new
		             position: 10 asPoint;
		             markup:
			             '<span foreground="blue" font_family="Ubuntu Regular"><b>bold </b>
<u> is </u>
<i> nice </i>
</span>
<span foreground="red" font_family="Ubuntu Mono"><tt> hello </tt></span>
<span foreground="black" font_family="sans" font_stretch="ultracondensed" letter_spacing="500" font_weight="light">SANS</span><span foreground="#FFCC00"> colored</span>';
		             "draggable;
		             yourself. "
		             notedWithPad: Float goldenRatio.


	pangoText draggable.

	RSCanvas new
		add: pangoText;
		add: (RSCircle new
				 radius: Float goldenRatio;
				 position: 0 asPoint;
				 color: Color red;
				 yourself);
		add: (RSLabel new
				 text: 'hello';
				 position: 0 @ 0;
				 draggable;
				 yourself);
		zoomToFit;
		addInteraction: RSCanvasController new;
		"showEncompassingRectangles;"open
]