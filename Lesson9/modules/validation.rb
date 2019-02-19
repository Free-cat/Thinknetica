module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(key, type, format = nil)
      case type
      when :presence then validate_presence(key)
      when :format then validate_format(key, format)
      when :type then validate_presence(key)
      when :length then validate_length(key, format)
      else; raise "Not allow type is #{type}"
      end
    end

    private

    def validate_presence(key)
      define_method("validate_presence_#{key}") do
        raise "#{key} is presence" if instance_variable_get("@#{key}").nil?
      end
    end

    def validate_length(key, format)
      define_method("validate_length_#{key}") do
        if instance_variable_get("@#{key}").to_s.length < format.to_i
          raise "#{key} should be at least #{format} symbols"
        end
      end
    end

    def validate_format(key, format)
      define_method("validate_format_#{key}") do
        if (instance_variable_get("@#{key}") =~ format).nil?
          raise "Not a format #{format}"
        end
      end
    end

    def validate_type(key, type)
      define_method("validate_type_#{key}") do
        variable = instance_variable_get("@#{key}")
        if variable.is_a?(Array)
          variable.each { |item| type_check(item, type) }
        else
          type_check(variable, type)
        end
      end
    end

    def type_check(element, type)
      raise "Not a type #{type}" unless element.is_a?(type)
    end
  end

  module InstanceMethods
    def validate!
      find_validation.each(&method(:send))
      true
    end

    def valid?
      begin
        validate!
      rescue StandardError
        return false
      end
      true
    end

    private

    def find_validation
      methods.grep /validate_/
    end
  end
end
