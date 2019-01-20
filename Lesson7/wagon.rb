require_relative 'company_name/company_name'

class Wagon
  include CompanyName
  attr_reader :type

  def initialize(type, company_name)
    @type = type
    @company_name = company_name
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected
  def validate!
    raise "Type can't be nil" if type.nil? || type == ''
    raise "Company_name can't be nil and blank" if company_name.nil? || company_name == ''
  end
end