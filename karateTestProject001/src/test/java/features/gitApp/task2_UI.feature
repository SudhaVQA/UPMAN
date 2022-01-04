Feature: UI test

  Scenario Outline: Test Task2 UI
    * configure driver = { type: 'chrome', executable: 'C:/Program Files/Google/Chrome/Application/chrome.exe', headless: false , addOptions : ['--disable-popup-blocking'] }
    * configure ssl = true
    Given driver 'https://www.accuweather.com/en/search-locations?query='+'<CityName>'
    And driver.maximize()
    And delay(1000)
    And waitFor("//a[contains(text(),'<CityName>, <CountryName>')]")
    And click("//a[contains(text(),'<CityName>, <CountryName>')]")
    * delay(1000)
    And driver.reload()
    * delay(1000)
   * if (exists("//a[contains(text(),'<CityName>, <CountryName>')]")) click("//a[contains(text(),'<CityName>, <CountryName>')]")
    * if (exists("//*[@id='dismiss-button']/div/span")) click("//*[@id='dismiss-button']/div/span")
    * delay(1000)
    And waitFor("//h2[contains(text(),'Current Weather')]")
    * if (exists("//a[1]/div[1]/div[1]/div/div/div[1]")) var currWeather = script("//a[1]/div[1]/div[1]/div/div/div[1]",'_.textContent')
    And karate.log('currWeather is: '+currWeather)
    * def CurrWeatherNumber = currWeather.split('°')[0]
    And karate.log('CurrWeatherNumber is: '+CurrWeatherNumber)
    * def api_Temp = call read('task1_API.feature')
    And karate.log('api_Temp is: '+api_Temp.currTemp)
    * def variance = <Variance>
    * def tempComparision =
   """
function(arg){

  var message = ''
  karate.log('arg.CurrWeatherNumber: '+arg.CurrWeatherNumber + ' and arg.api_Temp: '+ arg.api_Temp + ' and arg.variance: ' + variance)
  var diff = arg.CurrWeatherNumber - arg.api_Temp
  karate.log('Temp difference between UI and API is: ' + diff)
  if( diff >= 0 && diff <= arg.variance)
 {
  message = 'Success as temperature difference is within given variance ' + arg.variance
  karate.log('Success as temperature difference is within given variance') + arg.variance
  }

  else{
   message = 'Failure as temperature difference is exceeding given variance'
  karate.log('Failure as temperature difference is exceeding given variance')
  }

return message
}
   """

    * def output = call tempComparision {CurrWeatherNumber : '#(CurrWeatherNumber)' , api_Temp : '#(api_Temp.currTemp)' , variance : '#(variance)'}
   And karate.log('Comparision Message= ' +output);

    Examples:
      |CityName|CountryName|Variance|
      | London       | GB | 2       |



