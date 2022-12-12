SimpleForm.setup do |config|
  config.error_notification_class = 'no'
  config.button_class = 'waves-effect waves-light btn'
  config.boolean_label_class = nil
  config.item_wrapper_tag = :p
  config.wrappers :vertical_form, tag: 'div', class: 'input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input
    b.use :label
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end
  config.wrappers :vertical_text_input, tag: 'div', class: 'input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'materialize-textarea'
    b.use :label
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end
  config.wrappers :vertical_file_input, tag: 'div', class: 'file-field input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.wrapper tag: :div, class: 'btn' do |c|
      c.use :label, class: 'file_label'
      c.use :input, type: 'file'
    end
    b.use :input, class: 'file-path', type: 'text', name: "filename", id: "filename", wrap_with: { tag: 'div', class: 'file-path-wrapper'}, value: "Filename"
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end
  config.wrappers :vertical_boolean, tag: 'div', class: 'input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'div', class: 'checkbox' do |ba|
      ba.use :label_input
    end
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :vertical_checkboxes, tag: 'p', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input
    b.use :label
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end

  config.wrappers :vertical_checkboxes_with_label, tag: 'p', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'bigger-label'
    b.use :input
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end

  config.wrappers :vertical_radios, tag: 'p', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'bigger-label'
    b.use :input
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end
  config.wrappers :horizontal_radios, tag: 'p', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'bigger-label', wrap_with: {tag: 'div', class: 'col s12 l3'}
    b.wrapper tag: 'div', class: 'col s12 l9' do |d|
      d.use :input
    end
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end
  config.wrappers :vertical_selection, error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'bigger-label'
    b.use :input
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'div', class: 'card-panel red darken-4 white-text' }
  end

  config.wrappers :inline_form, tag: 'div', class: 'input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
  check_boxes: :vertical_checkboxes,
  radio_buttons: :vertical_radios,
  file: :vertical_file_input,
  boolean: :vertical_boolean,
  }
end
