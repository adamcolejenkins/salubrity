@defaultSettings = ['label', 'instructions']

@salubrity
  
  .constant 'CONFIG',

    fieldTypes: [
      {
        enabled: true,
        label: 'Welcome Screen',
        type: 'intro',
        icon: 'sign-in',
        noSort: true,
        templates: {
          view: '/templates/fields/view/into.html'
        },
        settings: @defaultSettings.concat('attachment', 'intro'),
        defaults: {
          button_label: 'Start'
        }
      },{
        enabled: true,
        label: 'Thank You Screen',
        type: 'outro',
        icon: 'sign-out',
        noSort: true,
        templates: {
          view: '/templates/fields/view/outro.html'
        },
        settings: @defaultSettings.concat('attachment', 'outro'),
        defaults: {
          button_label: 'Again',
          button_mode: 'reload'
        }
      },
      {
        enabled: true,
        label: 'Single Line Text',
        type: 'single_line_text',
        icon: 'font',
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
        type: 'paragraph_text',
        icon: 'paragraph',
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
          type: 'multiple_choice',
          icon: 'dot-circle-o',
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
          type: 'number',
          icon: 'slack',
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
          enabled: true,
          label: 'Checkboxes',
          type: 'checkboxes',
          icon: 'check-square-o',
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
          type: 'dropdown',
          icon: 'toggle-down',
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
          type: 'scale',
          icon: 'tasks',
          templates: {
              preview: '/templates/fields/preview/scale.html',
              view: '/templates/fields/view/scale.html'
          },
          settings: @defaultSettings.concat('range', 'value', 'increment', 'options', 'visibility', 'required'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      },{
          enabled: true,
          label: 'Rating',
          type: 'rating',
          icon: 'star-half-full',
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
          enabled: true,
          label: 'Date',
          type: 'date',
          icon: 'calendar-o',
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
          enabled: true,
          label: 'Time',
          type: 'time',
          icon: 'clock-o',
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