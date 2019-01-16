require_relative 'company_name/company_name'

class Wagon
  include CompanyName
  attr_reader :type

  def initialize(type, company_name)
    @type = type
    @company_name = company_name
  end
end