module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      create_history_method(name, var_name)
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Not allowed type of var' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end

  private

  def create_history_method(name, var_name)
    var_name_history = "@#{name}_history".to_sym
    define_method("#{name}_history") do
      instance_variable_get(var_name_history)
    end
    define_method("#{name}=".to_sym) do |value|
      new_array = instance_variable_get(var_name_history).to_a << value
      instance_variable_set(var_name_history, new_array)
      instance_variable_set(var_name, value)
    end
  end
end
