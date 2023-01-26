require 'test_helper'

class ImcTest < ActionDispatch::IntegrationTest
  test 'should respond with forbidden if token is invalid' do
    post '/imc'

    assert_response :forbidden
  end

  test 'expired jwt fails' do
    post '/imc', headers: { 'HTTP_AUTHORIZATION' => 'Bearer ' + build_jwt(-1) }

    assert_response :forbidden
  end

  test 'should respond with 400 when the params are missing' do
    post '/imc', headers: { 'HTTP_AUTHORIZATION' => 'Bearer ' + build_jwt },
                 params: { height: 1.70, weight: 76 }
    assert_response 400

    assert_equal(
      { 'error' => 'param is missing or the value is empty: imc' },
      JSON.parse(response.body)
    )
  end

  test 'should respond with 422 when receives invalid params' do
    post '/imc', headers: { 'HTTP_AUTHORIZATION' => 'Bearer ' + build_jwt },
                 params: { imc: { height: '' } }

    assert_response 422

    assert_equal(
      { 'imc' => { 'height' => ["can't be blank"], 'weight' => ["can't be blank"] } },
      JSON.parse(response.body)
    )
  end

  test 'should respond with 422 when missing some param' do
    post '/imc', headers: { 'HTTP_AUTHORIZATION' => 'Bearer ' + build_jwt },
                 params: { imc: { height: '', weight: 76 } }

    assert_response 422

    assert_equal(
      { 'imc' => { 'height' => ["can't be blank"] } },
      JSON.parse(response.body)
    )
  end

  test 'should respond with success when receives valid params' do
    post '/imc', headers: { 'HTTP_AUTHORIZATION' => 'Bearer ' + build_jwt },
                 params: { imc: { height: 1.85, weight: 85 } }

    assert_response 200

    imc = JSON.parse(response.body)

    assert_equal(imc.as_json, imc)
  end

  test 'should respond with token and success' do
    get '/get_token'

    build_jwt

    assert_response 200
    token = JSON.parse(response.body)

    assert_equal(token.as_json, token)
  end

  def build_jwt(valid_for_minutes = 5)
    exp = Time.now.to_i + (valid_for_minutes * 60)
    payload = { "iss": 'fusionauth.io',
                "exp": exp,
                "aud": '238d4793-70de-4183-9707-48ed8ecd19d9',
                "sub": '19016b73-3ffa-4b26-80d8-aa9287738677',
                "name": 'Dan Moore',
                "roles": ['USER'] }
    JWT.encode payload, 'HS256'
  end
end
