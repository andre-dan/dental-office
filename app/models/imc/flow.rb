class Imc
  class Flow < Micro::Case
    flow Step::NormalizeParams,
         Step::ValidateMeasurements,
         Step::CalculateImc,
         Step::SerializeAsJson
  end
end
