require_relative 'company_name/company_name'
require_relative 'instance_counter/instance_counter'
require_relative 'modules/validation'

class Wagon
  include Validation
  include CompanyName
  attr_reader :type
  attr_reader :id

  validate :type, :presence
  validate :company_name, :presence

  def initialize(type, company_name)
    @type = type
    @company_name = company_name
  end
end
