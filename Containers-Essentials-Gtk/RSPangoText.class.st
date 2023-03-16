"
I am a shape that represent a rich text and visualizes it via Pango.
"
Class {
	#name : #RSPangoText,
	#superclass : #RSBoundingShape,
	#instVars : [
		'markup',
		'fontDescription',
		'baseline',
		'pangoLayout'
	],
	#category : #'Containers-Essentials-Gtk'
}

{ #category : #visiting }
RSPangoText >> accept: aVisitor [

	^ aVisitor visitPangoText: self
]

{ #category : #initialization }
RSPangoText >> finalize [

	pangoLayout isNull ifFalse: [
		| ll |
		ll := LibLua uniqueInstance.

		ll withOpenedLibsStateDo: [ :L |
			ll
				luaL_requiref: L name: 'cairo';
				on: L push: #cairo.

			ll
				lua_getfield: L
				at: -1
				name: 'g_object_unref'
				remove: true.

			ll assert: [
				ll
					on: L push: pangoLayout;
					lua_pcall: L nargs: 1 nresults: 0 ].

			pangoLayout := ExternalAddress null.

			'pango freed' traceCr ] ].

	^ super finalize
]

{ #category : #accessing }
RSPangoText >> fontDescription [

	^ fontDescription
]

{ #category : #accessing }
RSPangoText >> fontDescription: anObject [

	fontDescription := anObject.

	self updateBaseRectangle
]

{ #category : #testing }
RSPangoText >> hasText [

	^ markup ifNil: [ false ] ifNotNil: [ markup isNotEmpty ]
]

{ #category : #initialization }
RSPangoText >> initPangoLayout: aPangoLayout [

	aPangoLayout fontDescription: self fontDescription.
	aPangoLayout markup: (self markup ifNil: [ '' ])
]

{ #category : #initialization }
RSPangoText >> initialize [

	super initialize.

	pangoLayout := ExternalAddress null.

	"ll := LibLua uniqueInstance.

	L := luaState.

	ll
		luaL_requiref: L name: 'cairo';
		on: L push: #cairo.

	ll
		lua_getfield: L
		at: -1
		name: 'pango_layout_with_default_font_map'
		remove: true.

	code := ll lua_pcall: L nargs: 0 nresults: 3.

	code = ll LUA_OK
		ifTrue: [
			| isLayout |
			""				ll
					on: L push: #layout;
					on: L push: #map;
					on: L push: #ctx.
""
			pangoLayout := ll on: L at: -3.
			pangoFontMap := ll on: L at: -2.
			pangoContext := ll on: L at: -1.

			ll lua_pop: L nelements: 3.

			""Checking""
			ll
				on: L push: #cairo;
				lua_getfield: L
				at: -1
				name: 'pango_is_layout'
				remove: true.

			isLayout := ll
				            on: L push: pangoLayout;
				            lua_pcall: L nargs: 1 nresults: 1;
				            on: L at: -1.

			self assert: isLayout.

			'is really a Pango layout' traceCr ]
		ifFalse: [ (ll on: L at: -1) inspect ]."

	self class finalizationRegistry add: self
]

{ #category : #accessing }
RSPangoText >> markup [

	^ markup
]

{ #category : #accessing }
RSPangoText >> markup: anObject [

	markup := anObject.

	self updateBaseRectangle
]

{ #category : #accessing }
RSPangoText >> updateBaseRectangle [


]

{ #category : #accessing }
RSPangoText >> updateBaseRectangle1 [

	| ll |
	ll := LibLua uniqueInstance.

	ll withOpenedLibsStateDo: [ :L |
		| code |
		ll
			luaL_requiref: L name: 'cairo';
			on: L push: #cairo.

		ll
			lua_getfield: L
			at: -1
			name: 'pango_layout_set_markup'
			remove: true.

		code := ll
			        on: L push: pangoLayout;
			        on: L push: self markup;
			        lua_pcall: L nargs: 2 lets: #( w h b ).

		code = ll LUA_OK
			ifTrue: [
				| w h b |
				ll
					on: L push: #w;
					on: L push: #h;
					on: L push: #b.

				w := ll on: L at: -3.
				h := ll on: L at: -2.
				b := ll on: L at: -1.

				ll lua_pop: L nelements: 3.

				baseRectangle := Rectangle floatCenter: 0.0 asPoint extent: w @ h ]
			ifFalse: [ (ll on: L at: -1) inspect ] ]
]

{ #category : #accessing }
RSPangoText >> updateBaseRectangleOnCairoCanvas: cairo_t [

	| ll |
	pangoLayout isNull ifFalse: [ ^ self ].

	ll := LibLua uniqueInstance.

	ll withOpenedLibsStateDo: [ :L |
		| code |
		ll
			luaL_requiref: L name: 'cairo';
			on: L push: #cairo.

		ll
			lua_getfield: L
			at: -1
			name: 'pango_cairo_create_layout'
			remove: true.

		code := ll
			        on: L push: cairo_t;
			        lua_pcall: L nargs: 1 nresults: 1.

		code = ll LUA_OK
			ifTrue: [
				pangoLayout := ll on: L at: -1.

				ll lua_pop: L nelements: 1.

				baseRectangle := Rectangle floatCenter: 0.0 asPoint extent: 0 @ 0 ]
			ifFalse: [ (ll on: L at: -1) inspect ] ]
]
