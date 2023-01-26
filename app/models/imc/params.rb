class Imc::Params
  def self.to_save(params)
    params.require(:imc).permit(:height, :weight)
  end
end
