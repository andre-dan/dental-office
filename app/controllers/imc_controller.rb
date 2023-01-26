class ImcController < ApplicationController
  before_action :require_jwt, only: %i[imc]

  def imc
    Imc::Flow
      .call(params:)
      .on_failure(:parameter_missing) { |error| render_json(400, error: error[:message]) }
      .on_failure(:invalid_imc_params) { |imc| render_json(422, imc: imc[:errors]) }
      .on_success { |result| render_json(200, result) }
  end

  def get_token(valid_for_minutes = 15)
    exp = Time.now.to_i + (valid_for_minutes * 60)
    payload = { "iss": 'fusionauth.io',
                "exp": exp,
                "aud": '238d4793-70de-4183-9707-48ed8ecd19d9',
                "sub": '19016b73-3ffa-4b26-80d8-aa9287738677',
                "name": 'Dan Moore',
                "roles": ['USER'] }

    render_json(200, token: (JWT.encode payload, 'HS256'))
  end
end
