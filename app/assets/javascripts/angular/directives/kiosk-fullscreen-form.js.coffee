@salubrity
	
	.directive 'kiosk', ($timeout) ->
		return (
			restrict: 'A'
			link: ($scope, $elem, attrs) ->

				# Check for required plugins
				return throw new Error 'Modernizr not found' if typeof Modernizr == 'undefined'
				return throw new Error 'Classie not found' if typeof classie == 'undefined'
				return throw new Error 'Moment not found' if typeof moment == 'undefined'

				support = 
					animations: Modernizr.cssanimations

				animEndEventNames =
					'WebkitAnimation' : 'webkitAnimationEnd'
					'OAnimation'			: 'oAnimationEn'
					'msAnimation'			: 'MSAnimationEnd'
					'animation'				: 'animationend'

				animEndEventName = animEndEventNames[ Modernizr.prefixed('animation') ]


				###*
				 * extend obj function
				 * @param	 {object} a destination object
				 * @param	 {object} b source object
				 * @return {object}		reference to destination
				###
				extend = (a, b) ->
					for key of b
						a[key] = b[key]	 if b.hasOwnProperty(key)
					a

				###*
				 * createElement function
				 * @param	 {string} tag DOMElement to create
				 * @param	 {object} opt options for the DOM element
				 * @return {object}			DOM Element
				###
				createElement = (tag, opt) ->
					el = document.createElement(tag)
					if opt
						el.className = opt.cName	if opt.cName
						el.innerHTML = opt.inner	if opt.inner
						opt.appendTo.appendChild el	 if opt.appendTo
					el


				Kiosk = (el, options) ->
					@el = el
					@options = extend({}, @options)
					extend @options, options
					@_init()
					return


				###*
				 * Kiosk Options
				 * @type {object}
				###
				Kiosk::options = 
					# show progress bar
					ctrlProgress: true
					# show navigation dots
					ctrlNavDots: true
					# show [current field]/[total fields] status
					ctrlNavPosition: true
					# reached the review and submit step
					onReview: -> false

	
				###*
				 * Init function
				 * @return {void} Initialize and cache vars
				###
				Kiosk::_init = ->
					# the form element
					@formEl = @el.querySelector("form")
					
					# list of fields
					@fieldsList = @formEl.querySelector("ol.kiosk-fields")

					# current field position
					@current = 0

					# all fields
					@fields = [].slice.call( @fieldsList.children )

					# total fields
					@fieldsCount = @fields.length

					# show first field
					classie.add( @fields[ @current ], 'kiosk-current' )

					# create/add controls
					@_addControls()

					# create/add messages
					@_addErrorMsg()

					# init events
					@_initEvents()
				

				###*
				 * addControls function
				 * create and insert the structure for the controls
				###
				Kiosk::_addControls = ->
					# main controls wrapper
					@ctrls = createElement("div",
						cName: "kiosk-controls"
						appendTo: @el
					)

					# start button
					@ctrlStart = @el.querySelector( '.kiosk-start' )

					# continue button (jump to next field)
					@ctrlContinue = createElement("button",
						cName: "kiosk-continue"
						inner: "Continue"
						appendTo: @ctrls
					)
					@_showCtrl @ctrlContinue if @ctrlStart is undefined
					
					# navigation dots
					if @options.ctrlNavDots
						@ctrlNav = createElement("nav",
							cName: "kiosk-nav-dots"
							appendTo: @ctrls
						)

						dots = ""
						i = 0
						while i < @fieldsCount
							dots += (if i is @current then "<button class=\"kiosk-dot-current\"></button>" else "<button disabled></button>")
							++i

						@ctrlNav.innerHTML = dots
						@_showCtrl @ctrlNav
						@ctrlNavDots = [].slice.call( @ctrlNav.children )
					
					# field number status
					if @options.ctrlNavPosition
						@ctrlFldStatus = createElement("span",
							cName: "kiosk-numbers"
							appendTo: @ctrls
						)
						
						# current field placeholder
						@ctrlFldStatusCurr = createElement("span",
							cName: "kiosk-number-current"
							inner: Number(@current + 1)
						)
						@ctrlFldStatus.appendChild @ctrlFldStatusCurr
						
						# total fields placeholder
						@ctrlFldStatusTotal = createElement("span",
							cName: "kiosk-number-total"
							inner: @fieldsCount
						)
						@ctrlFldStatus.appendChild @ctrlFldStatusTotal
						@_showCtrl @ctrlFldStatus
					
					# progress bar
					if @options.ctrlProgress
						@ctrlProgress = createElement("div",
							cName: "kiosk-progress"
							appendTo: @ctrls
						)
						@_showCtrl @ctrlProgress

					return


				###*
				 * addErrorMsg function
				 * create and insert the structure for the error message
				###
				Kiosk::_addErrorMsg = ->
					
					# error message
					@msgError = createElement("span",
						cName: "kiosk-message-error"
						appendTo: @el
					)
					return


				Kiosk::_initEvents = ->
					self = this

					# start form fields
					@ctrlStart.addEventListener 'click', ->

						# add a timestamp to form kiosk-started-at and start form
						self._setFieldTime self.formEl, 'started-at'
						self._nextField()
						self._showCtrl self.ctrlContinue


					# show next field
					@ctrlContinue.addEventListener "click", ->
						self._nextField()
						return

					# navigation dots
					if @options.ctrlNavDots
						@ctrlNavDots.forEach (dot, pos) ->
							dot.addEventListener "click", ->
								self._showField pos
								return
							return

					# jump to the next field without clicking the continue button
					# (for fields/list items with the attribute "data-input-trigger")
					@fields.forEach ( fld ) ->
						if fld.hasAttribute( 'data-input-trigger' )
							# assuming only radio and select elements
							input = fld.querySelector( 'input[type="radio"]' ) or fld.querySelector( '.cs-select' ) or fld.querySelector( 'select' )
							return unless input

							switch input.tagName.toLowerCase()
								when 'select'
									input.addEventListener 'change', -> self._nextField()
									return

								when 'input'
									[].slice.call( fld.querySelectorAll( 'input[type="radio"]' ) ).forEach ( inp ) ->
										inp.addEventListener 'change', ( ev ) -> self._nextField()
									return

								when 'div'
									[].slice.call( fld.querySelectorAll( 'ul > li' ) ).forEach ( inp ) ->
										inp.addEventListener 'click', ( ev ) -> self._nextField()
									return


					# keyboard navigation events - jump to next field when pressing enter
					document.addEventListener 'keydown', ( ev ) ->
						if not self.isLastStep and ev.target.tagName.toLowerCase() isnt "textarea"
							keyCode = ev.keyCode or ev.which
							if keyCode is 13
								ev.preventDefault()
								self._nextField()


				###*
				 * nextField function
				 * jumps to the next field
				 * @param	 {inte}		backto quick jump back to field
				 * @return {[type]}				 [description]
				###
				Kiosk::_nextField = ( backto ) ->
					return false if @isLastStep or not @_validity() or @isAnimating
					@isAnimating = true

					# check if on last step
					@isLastStep = (if @current is @fieldsCount - 1 and backto is `undefined` then true else false)

					# clear any previous error messages
					@._clearError()

					# current field
					currentFld = @fields[@current]

					# TODO: ADD FIELD ENDED_AT TIMESTAMP HERE
					@_setFieldTime currentFld, 'ended-at'

					# save the navigation direction
					@navdir = (if backto isnt `undefined` then (if backto < @current then "prev" else "next") else "next")

					# update current field
					@current = (if backto isnt `undefined` then backto else @current + 1)

					if backto is undefined
						# update progress bar (unless we navigate backwards)
						@_progress()

						# save farthest position so far
						@farthest = @current

					# add class "kiosk-display-next" or "kiosk-display-prev" to the list of fields
					classie.add @fieldsList, "kiosk-display-#{@navdir}"

					# remove class "kiosk-current" from current field and add it to the next one
					# also add class "kiosk-show" to the next field and the class "kiosk-hide" to the current one
					classie.remove currentFld, 'kiosk-current'
					classie.add currentFld, 'kiosk-hide'

					unless @isLastStep
						# update nav
						@_updateNav()

						# change the current field number/status
						@_updateFieldNumber()
						nextField = @fields[@current]
						classie.add nextField, "kiosk-current"
						classie.add nextField, "kiosk-show"

					# after animation ends remove added classes from fields and add started_at timestamp
					self = this
					onEndAnimationFn = ( ev ) ->
						@removeEventListener animEndEventName, onEndAnimationFn	 if support.animations

						classie.remove self.fieldsList, "kiosk-display-#{self.navdir}"
						classie.remove currentFld, 'kiosk-hide'

						if self.isLastStep
							# show the complete form and hide the controls
							self._hideCtrl self.ctrlNav
							self._hideCtrl self.ctrlProgress
							self._hideCtrl self.ctrlContinue
							self._hideCtrl self.ctrlFldStatus

							# replace class "kiosk-form-full" with "kiosk-form-overview"
							classie.remove self.formEl, 'kiosk-form-full'
							classie.add self.formEl, 'kiosk-form-overview'
							classie.add self.formEl, 'kiosk-show'

							# Add a timestamp to form kiosk-ended-at
							self._setFieldTime self.formEl, 'ended-at'

							# callback
							self.options.onReview()

						else
							classie.remove nextField, 'kiosk-show'

							if self.options.ctrlNavPosition
								self.ctrlFldStatusCurr.innerHTML = self.ctrlFldStatusNew.innerHTML
								self.ctrlFldStatus.removeChild self.ctrlFldStatusNew
								classie.remove self.ctrlFldStatus, "kiosk-show-#{self.navdir}"

							# Add a timestamp to nextField kiosk-started-at
							self._setFieldTime nextField, 'started-at'

						self.isAnimating = false

					if support.animations
						if @navdir is "next"
							if @isLastStep
								currentFld.querySelector( ".kiosk-anim-upper" ).addEventListener animEndEventName, onEndAnimationFn
							else
								nextField.querySelector( ".kiosk-anim-lower" ).addEventListener animEndEventName, onEndAnimationFn
						else
							nextField.querySelector( ".kiosk-anim-upper" ).addEventListener animEndEventName, onEndAnimationFn
					else
						onEndAnimationFn()

					return


				###*
				 * showField function
				 * @param	 {int} pos field position
				 * @return {void}			calls another function
				###
				Kiosk::_showField = ( pos ) ->
					return false	if pos is @current or pos < 0 or pos > @fieldsCount - 1
					@_nextField pos
					return


				###*
				 * updateFieldNumber function
				 * changes the current field number
				 * @return {void} 
				###
				Kiosk::_updateFieldNumber = ->
					if @options.ctrlNavPosition
						@ctrlFldStatusNew = createElement 'span',
							cName: 'kiosk-number-new'
							inner: Number @current + 1
							appendTo: @ctrlFldStatus

						# add class "kiosk-show-next" or "kiosk-show-prev" depending on the navigation direction
						self = this
						setTimeout (->
							classie.add self.ctrlFldStatus, (if self.navdir is "next" then "kiosk-show-next" else "kiosk-show-prev")
							return
						), 25
					return


				###*
				 * progress function
				 * updates the progress bar by setting its width
				 * @return {void} 
				###
				Kiosk::_progress = ->
					@ctrlProgress.style.width = @current * (100 / @fieldsCount) + "%"	 if @options.ctrlProgress
					return


				###*
				 * updateNav function
				 * updates the navigation dots
				 * @return {void} 
				###
				Kiosk::_updateNav = ->
					if @options.ctrlNavDots
						classie.remove @ctrlNav.querySelector( "button.kiosk-dot-current" ), "kiosk-dot-current"
						classie.add @ctrlNavDots[ @current ], "kiosk-dot-current"
						@ctrlNavDots[ @current ].disabled = false
					return


				###*
				 * validity function
				 * TODO: this is a very basic validation function. Only checks or required fields. 
				 * @return {[bool]} whether the field is valid or not
				###
				Kiosk::_validity = ->
					fld = @fields[ @current ]
					input = fld.querySelector( "input[required]" ) or fld.querySelector( "textarea[required]" ) or fld.querySelector( "select[required]" )
					error = undefined

					return true	 unless input

					switch input.tagName.toLowerCase()

						when 'input'
							if input.type is "radio" or input.type is "checkbox"
								checked = 0
								[].slice.call( fld.querySelectorAll( "input[type=\"#{input.type}\"]" ) ).forEach (inp) ->
									++checked	 if inp.checked
									return

								error = "NOVAL"	 unless checked
							else error = "NOVAL"	if input.value is ""

						when 'select'
							# assuming here '' or '-1' only
							error = "NOVAL"	 if input.value is "" or input.value is "-1"

						when 'textarea'
							error = "NOVAL"	 if input.value is ""

					if error?
						@_showError error
						return false

					true
				
				
				###*
				 * setFieldtime function
				 * sets a timestamp to a given field
				 * @param {object} el   the element to add a timestamp to
				 * @param {string} cName the class name of the hidden field [started-at|ended-at]
				###
				Kiosk::_setFieldTime = ( el, cName ) ->
					fld = el.querySelector( ".kiosk-#{cName}" )
					fld.value = moment().format()  if fld
					return
		

				###*
				 * showError function
				 * shows an error if validity fails
				 * @param	 {err} err error code
				 * @return {void}			
				###
				Kiosk::_showError = (err) ->
					message = ""

					switch err
						when "NOVAL"
							message = "Please fill the field before continuing"

						when "INVALIDEMAIL"
							message = "Please fill a valid email address"
					
					# ...
					@msgError.innerHTML = message
					@_showCtrl @msgError
					return

				###*
				 * clearError function
				 * clears/hides the current error message
				 * @return {[type]} [description]
				###
				Kiosk::_clearError = ->
					@_hideCtrl @msgError
					return


				###*
				 * showCtrl function
				 * shows a control
				 * @param	 {object} ctrl the DOM element to add the class
				 * @return {void}
				###
				Kiosk::_showCtrl = ( ctrl ) ->
					classie.add ctrl, 'kiosk-show'
					return


				###*
				 * hideCtrl function
				 * hides a control
				 * @param	 {object} ctrl the DOM element to remove the class
				 * @return {void}	
				###
				Kiosk::_hideCtrl = ( ctrl ) ->
					classie.remove ctrl, 'kiosk-show'
					return


				###*
				 * Instantiate the Kiosk object
				 * @return {void} starts the magic!
				###
				new Kiosk($elem[0],
					onReview: ->
						angular.element('body').addClass('overview')
				)

		) # end directive return