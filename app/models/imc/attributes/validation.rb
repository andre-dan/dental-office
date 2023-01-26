class Imc::Attributes::Validation
  attr_reader :height, :weight, :errors

  def initialize(height, weight)
    @errors = {}
    @height = height
    @weight = weight

    perform
  end

  def errors?
    errors.present?
  end

  private

  def perform
    errors[:height] = ["can't be blank"] if height.blank? || height.value.zero?
    errors[:weight] = ["can't be blank"] if weight.blank? || weight.value.zero?
  end
end
