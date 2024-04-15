Feature: Get lists by brand

  Background:
    * url baseUrl
    * print  baseUrl
    * def responseJson200 = read("classpath:../schema_response/responseProductoJson200.json")
    * print responseJson200

  @successfull
  Scenario Outline:
    Given params { product_type:"<product_type>", product_category:"<product_category>"}
    When method get
    * def jsonResponse = response

    * print jsonResponse
    Then status 200
    And match jsonResponse contains responseJson200
    And match jsonResponse[0].product_type contains "<product_type>"
    And match jsonResponse[0].category contains "<product_category>"

    Examples:
      |product_type|product_category|
      |eyeliner    |cream           |
      |blush       |cream           |
      |lipstick    |liquid          |


  @fail
  Scenario Outline:
    Given url 'http://makeup-api.herokuapp.com/'
    And path 'api/<path>/' + 'products.json?'
    And params { brand: "<brand>", product_type:"<product_type>" }
    When method get
    * def jsonResponse = response

    * print jsonResponse
    Then status 404
    And match responseType == "string"
    And match response contains "<html>"

    Examples:
      |product_type|product_category|path|
      |eyeliner    |cream           |ddd |
      |blush       |cream           |    |
      |mascara     |liquid          |222 |