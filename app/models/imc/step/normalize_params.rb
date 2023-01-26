class Imc::Step::NormalizeParams < Micro::Case
  attribute :params

  validates! :params, type: ActionController::Parameters

  def call!
    imc_params = Imc::Params.to_save(params)
    Success do
      {
        height: Imc::Measurements.new(imc_params[:height]),
        weight: Imc::Measurements.new(imc_params[:weight])
      }
    end
  rescue ActionController::ParameterMissing => e
    Failure(:parameter_missing) { { message: e.message } }
  end
end
