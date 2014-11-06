@defaultSettings = ['label', 'instructions']

@salubrity
  
  .constant 'CONFIG',

    fieldContexts: [
      {
        enabled: true, # We need this for outro text, global text with a variable
        label: 'Welcome Screen',
        context: 'intro',
        icon: 'sign-in',
        noSort: false,
        hasChoices: false,
        templates: {
          view: '/templates/fields/view/into.html'
        },
        settings: @defaultSettings.concat('attachment', 'intro'),
        defaults: {
          button_label: 'Start'
        }
      },{
        enabled: true, # We need this for outro text, global text with a variable
        label: 'Thank You Screen',
        context: 'outro',
        icon: 'sign-out',
        noSort: false,
        hasChoices: false,
        templates: {
          view: '/templates/fields/view/outro.html'
        },
        settings: @defaultSettings.concat('attachment', 'outro'),
        defaults: {
          button_label: 'Again',
          button_mode: 'reload'
        }
      },{
        enabled: true, # We need this for provider options, such as label
        label: 'Provider Dropdown'
        context: 'provider_dropdown'
        icon: 'user-md'
        templates: {
          view: '/templates/fields/view/provider_dropdown.html'
        },
        settings: @defaultSettings.concat('provider', 'options', 'required'),
        defaults: {

        }
      },{
        enabled: true,
        label: 'Single Line Text',
        context: 'single_line_text',
        icon: 'font',
        hasChoices: false,
        templates: {
          preview: '/templates/fields/preview/single_line_text.html',
          view: '/templates/fields/view/single_line_text.html'
        },
        settings: @defaultSettings.concat('range', 'value', 'options', 'visibility', 'required'),
        defaults: {
          required: true,
          visibility: 'public'
        }
      },{
        enabled: true,
        label: 'Paragraph Text',
        context: 'paragraph_text',
        icon: 'paragraph',
        hasChoices: false,
        templates: {
          preview: '/templates/fields/preview/paragraph_text.html',
          view: '/templates/fields/view/paragraph_text.html'
        },
        settings: @defaultSettings.concat('range', 'value', 'options', 'visibility', 'required'),
        defaults: {
          required: true,
          visibility: 'public'
        }
      },{
          enabled: true,
          label: 'Multiple Choice',
          context: 'multiple_choice',
          icon: 'dot-circle-o',
          hasChoices: true,
          templates: {
              preview: '/templates/fields/preview/multiple_choice.html',
              view: '/templates/fields/view/multiple_choice.html'
          },
          settings: @defaultSettings.concat('choices', 'layout', 'display', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public',
              layout: 'oneColumn',
              display_as: 'standard'
          }
      },{
          enabled: true,
          label: 'Number',
          context: 'number',
          icon: 'slack',
          hasChoices: false,
          templates: {
              preview: '/templates/fields/preview/number.html',
              view: '/templates/fields/view/number.html'
          },
          settings: @defaultSettings.concat('range', 'value', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: false,
          label: 'Checkboxes',
          context: 'checkboxes',
          icon: 'check-square-o',
          hasChoices: true,
          templates: {
              preview: '/templates/fields/preview/checkboxes.html',
              view: '/templates/fields/view/checkboxes.html'
          },
          settings: @defaultSettings.concat('choices', 'layout', 'display', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public',
              layout: 'oneColumn',
              display_as: 'standard'
          }
      },{
          enabled: true,
          label: 'Dropdown',
          context: 'dropdown',
          icon: 'toggle-down',
          hasChoices: true,
          templates: {
              preview: '/templates/fields/preview/dropdown.html',
              view: '/templates/fields/view/dropdown.html'
          },
          settings: @defaultSettings.concat('choices', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: true,
          label: 'Scale',
          context: 'scale',
          icon: 'tasks',
          hasChoices: false,
          templates: {
              preview: '/templates/fields/preview/scale.html',
              view: '/templates/fields/view/scale.html'
          },
          settings: @defaultSettings.concat('range', 'value', 'increment', 'options', 'visibility', 'required', 'median'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: false,
          label: 'Rating',
          context: 'rating',
          icon: 'star-half-full',
          hasChoices: false,
          templates: {
              preview: '/templates/fields/preview/rating.html',
              view: '/templates/fields/view/rating.html'
          },
          settings: @defaultSettings.concat('range', 'value', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: false,
          label: 'Date',
          context: 'date',
          icon: 'calendar-o',
          hasChoices: false,
          templates: {
              preview: '/templates/fields/preview/date.html',
              view: '/templates/fields/view/date.html'
          },
          settings: @defaultSettings.concat('date_format', 'value', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: false,
          label: 'Time',
          context: 'time',
          icon: 'clock-o',
          hasChoices: false,
          templates: {
              preview: '/templates/fields/preview/time.html',
              view: '/templates/fields/view/time.html'
          },
          settings: @defaultSettings.concat('time_format', 'value', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      }
    ]