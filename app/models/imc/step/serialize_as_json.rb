class Imc::Step::SerializeAsJson < Micro::Case
  attribute :imc

  def call!
    Success do
      imc.as_json
    end
  end
end
