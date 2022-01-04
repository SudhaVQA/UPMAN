@ignore
Feature: sample karate test script

  Scenario Outline: Get Current Weather Information for a given city using API
    Given url urlGetCurrWeather
    * configure ssl = true
    And param q = '<CityName>'
    And param appid = "7fe67bf08c80ded756e598d6f8fedaea"
    And param language = 'en-us'
    And param units = 'metric'
    When method GET
    Then status 200
    * def minTemp = response.main.temp_min
    * def maxTemp = response.main.temp_max
    * def currTemp = response.main.temp
    * def tempInfo = '\nCurrent Weather Temp Information: \ncurrTemp = ' +currTemp +'\nminTemp = ' +minTemp+'\nmaxTemp = ' +maxTemp
    And karate.log(tempInfo);
    * string apiResponse = response
    And karate.log('apiResponse is.. -->' +apiResponse);

    Examples:
    |CityName|
    | London         |

  