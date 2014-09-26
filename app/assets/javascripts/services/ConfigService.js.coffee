@defaultSettings = ['label', 'type', 'options', 'visibility', 'instructions']

@salubrity
  
  .constant 'CONFIG',

    fieldTypes: [
      {
        enabled: true,
        label: 'Single Line Text',
        type: 'single_line_text',
        icon: 'font',
        templates: {
          preview: '/templates/fields/preview/single_line_text.html',
          view: '/templates/fields/view/single_line_text.html'
        },
        settings: @defaultSettings.concat('range', 'field_size', 'values'),
        defaults: {
          required: true,
          visibility: 'public',
          field_size: 'medium'
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
        settings: @defaultSettings.concat('range', 'field_size', 'values'),
        defaults: {
          required: true,
          visibility: 'public',
          field_size: 'medium'
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
          settings: @defaultSettings.concat('choices', 'layout', 'display'),
          defaults: {
              required: true,
              visibility: 'public',
              field_choices: [
                  { label: "First Choice", key: "first_choice" },
                  { label: "Second Choice", key: "second_choice" },
                  { label: "Third Choice", key: "third_choice" }
              ],
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
          settings: @defaultSettings.concat('range', 'field_size', 'values'),
          defaults: {
              required: true,
              visibility: 'public',
              field_size: 'medium'
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
          settings: @defaultSettings.concat('choices', 'layout', 'display'),
          defaults: {
              required: true,
              visibility: 'public',
              field_choices: [
                  { label: "First Choice", key: "first_choice" },
                  { label: "Second Choice", key: "second_choice" },
                  { label: "Third Choice", key: "third_choice" }
              ],
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
          settings: @defaultSettings.concat('choices'),
          defaults: {
              required: true,
              visibility: 'public',
              field_choices: [
                  { label: "First Choice", key: "first_choice" },
                  { label: "Second Choice", key: "second_choice" },
                  { label: "Third Choice", key: "third_choice" }
              ]
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
          settings: @defaultSettings.concat('range', 'values', 'increment'),
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
          settings: @defaultSettings.concat('range', 'values'),
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
          settings: @defaultSettings.concat('date_format', 'values'),
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
          settings: @defaultSettings.concat('time_format', 'values'),
          defaults: {
              required: true,
              visibility: 'public'
          }
      }
    ]