class Imc::Step::CalculateImc < Micro::Case
  attributes :height, :weight

  def call!
    if height.present? && weight.present?
      result = classification
      return Success do
               { imc: {
                 imc: calculation.round(2),
                 classification: result[:classification],
                 obesity: result[:obesity]
               } }
             end
    end

    Failure(:invalid_imc_params) { { errors: imc.errors.as_json } }
  end

  private

  def calculation
    weight.value / (height.value * height.value)
  end

  def classification
    result = calculation
    obesity = ''
    string = case result
             when (0..18.5) then 'Magreza'
             when (18.5..24.9) then 'Peso normal'
             when (25..29.9) then 'Sobrepeso'
             when (30..34.9) then 'Obesidade grau I'
             when (35..40) then 'Obesidade grau II'
             when (40..Float::INFINITY) then 'Obesidade grau III'
             else 'Indefinido'
             end
    obesity = string.include?('grau') ? 
              string.partition('grau').last.strip : 
              string
    {classification: string, obesity: }
  end
end
