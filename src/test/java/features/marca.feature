Feature: Get lists by brand

  Background:
    * url baseUrl
    * print  baseUrl
    * def responseJson200 = read("classpath:../schema_response/responseMarcaJson200.json")
    * print responseJson200

  @successfull
  Scenario Outline:
    Given params { brand: "<brand>" }
    When method get
    * def jsonResponse = response

    * print jsonResponse
    Then status 201
    And match jsonResponse contains responseJson200
    And match jsonResponse[0].brand contains "<brand>"

    Examples:
      | brand      |
      | maybelline |
      | marcelle   |
      | iman       |


  @fail
  Scenario Outline:
    Given url 'http://makeup-api.herokuapp.com/'
    And path 'api/ddd/' + 'products.json?'
    And params { brand: "<brand>" }
    When method get
    * def jsonResponse = response
    * print jsonResponse
    Then status 404
    And match responseType == "string"
    And match response contains "<html>"

    Examples:
      | brand      |
      | maybelline |
      | marcelle   |
      | iman       |