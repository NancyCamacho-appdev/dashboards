class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currencies_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_currency")

    render({ :template => "currencies_templates/step_two.html.erb" })
  end

  def conversion
    #@raw_data = open("https://api.exchangerate.host/symbols").read
    #@parseddata = JSON.parse(@raw_data)
    #@symbols_hash = @parsed_data.fetch("symbols")
    #@array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_currency")
    @currency_symbol = params.fetch("to_currency")

    @currency_conversion_url = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@currency_symbol}").read
    @parsed_currency_data = JSON.parse(@currency_conversion_url)

    @exchange_rate = @parsed_currency_data.dig("info", "rate")

    #@info = @parsed_currency_data.fetch("info")
    #@rate = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@currency_symbol}").read

    render({ :template => "currencies_templates/conversion.html.erb" })
  end
end
