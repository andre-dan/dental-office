class Imc::Measurements
  attr_reader :value

  delegate :present?, :blank?, to: :value

  def initialize(value)
    @value = value&.to_f
  end
end
