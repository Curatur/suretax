module Suretax
  class Configuration
    attr_accessor :validation_key, :base_url

    def initialize
      register_currencies
    end

    private

    def register_currencies
      register_dollar_with_six_decimal_places
    end

    def register_dollar_with_six_decimal_places
      Money::Currency.register(
        {
          priority: 1,
          iso_code: "US6",
          iso_numeric: "840",
          name: "Dollar with six decimal places",
          symbol: "$",
          subunit: "Cent",
          subunit_to_unit: 1000000,
          symbol_first: true,
          html_entity: "$",
          decimal_mark: ".",
          thousands_separator: ",",
          symbolize_names: true
        }
      )
    end

  end
end
