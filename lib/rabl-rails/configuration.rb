module RablRails
  class Configuration
    attr_accessor :json_engine, :include_json_root, :enable_jsonp_callbacks
    attr_accessor :xml_options
    attr_accessor :plist_engine, :include_plist_root
    attr_accessor :cache_templates, :allow_empty_format_in_template
    attr_reader   :use_custom_responder
    attr_accessor :responder_default_template
    attr_accessor :replace_nil_values_with_empty_strings
    attr_accessor :replace_empty_string_values_with_nil
    attr_accessor :exclude_nil_values

    def initialize
      @json_engine            = defined?(::Oj) ? ::Oj : ::JSON
      @include_json_root      = true
      @enable_jsonp_callbacks = false

      @xml_options = { dasherize: true, skip_types: false }

      @plist_engine       = defined?(::Plist) ? ::Plist::Emit : nil
      @include_plist_root = false

      @cache_templates                = ActionController::Base.perform_caching
      @allow_empty_format_in_template = false

      @use_custom_responder       = false
      @responder_default_template = 'show'

      @replace_nil_values_with_empty_strings  = false
      @replace_empty_string_values_with_nil   = false
      @exclude_nil_values                     = false
    end

    def use_custom_responder=(value)
      @use_custom_responder = value
      require 'rabl-rails/responder' if value
    end

    def hash_modifiers?
      @modify_result ||= @replace_nil_values_with_empty_strings
    end
  end
end