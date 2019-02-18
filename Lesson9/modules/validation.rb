module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(key, type, format = nil)
      case type
      when :presence
        validate_presence(key)
      when :format
        validate_format(key, format)
      when :type
        validate_presence(key)
      else
        raise "Not allow type is #{type}"
      end
    end

    def validate_presence(key)
      define_method("validate_presence_#{key}") do
        raise "#{key} is presence" if instance_variable_get("@#{key}").nil?
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
        unless instance_variable_get("@#{key}").is_a?(type)
          raise "Not a type #{type}"
        end
      end
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

    def find_validation
      methods.grep /validate_/
    end
  end
end
