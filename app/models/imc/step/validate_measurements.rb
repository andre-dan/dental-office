class Imc::Step::ValidateMeasurements < Micro::Case
  attributes :height, :weight

  def call!
    validation =
        Imc::Attributes::Validation.new(height, weight)
        
    return Success { attributes } unless validation.errors?

    Failure(:invalid_imc_params) { { errors: validation.errors } }
  end
end
