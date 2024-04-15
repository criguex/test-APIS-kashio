Feature: Get lists by brand

  Background:
    * url baseUrl
    * print  baseUrl
    * def responseJson200 = read("classpath:../schema_response/responseProductoJson200.json")
    * print responseJson200

  @successfull
  Scenario Outline:
    Given params { product_type: "<product_type>" }
    When method get
    * def jsonResponse = response
    * print jsonResponse
    Then status 200
    And match jsonResponse contains responseJson200
    And match jsonResponse[0].product_type contains "<product_type>"

    Examples:
      | product_type|
      | eyeshadow   |
      | eyebrow     |
      | lipstick    |


  @fail
  Scenario Outline:
    Given url 'http://makeup-api.herokuapp.com/'
    And path 'api/ddd/' + 'products.json?'
    And params { product_type: "<product_type>" }
    When method get
    * def jsonResponse = response
    * print jsonResponse
    Then status 404
    And match responseType == "string"
    And match response contains "<html>"

    Examples:
      | product_type|
      | eyeshadow   |
      | eyebrow     |
      | lipstick    |