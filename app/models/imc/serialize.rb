class Imc::Serialize
  def self.as_json(imc)
    imc.as_json
  end

  class AsJson < Micro::Case
    attribute :imc

    def call!
      return Success { { imc: Imc::Serialize.as_json(imc) } } if imc.valid?

      Failure(:invalid_imc) { { errors: imc.errors.as_json } }
    end
  end
end
