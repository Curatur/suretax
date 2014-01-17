module RequestSpecHelper

  def valid_encoded_test_request_body
    {
      "BusinessUnit"             => "testing",
      "ClientNumber"             => suretax_client_number,
      "ClientTracking"           => "track",
      "DataMonth"                => "7",
      "DataYear"                 => "2013",
      "IndustryExemption"        => "",
      "ItemList"                 => [
        {
          "BillToNumber"         => "8585260000",
          "CustomerNumber"       => "000000007",
          "InvoiceNumber"        => "1",
          "LineNumber"           => "1",
          "OrigNumber"           => "8585260000",
          "P2PPlus4"             => "",
          "P2PZipcode"           => "",
          "Plus4"                => "",
          "RegulatoryCode"       => "99",
          "Revenue"              => "40",
          "SalesTypeCode"        => "R",
          "Seconds"              => "55",
          "TaxExemptionCodeList" => [
            "00",
            "00"
          ],
          "TaxIncludedCode"      => "0",
          "TaxSitusRule"         => "01",
          "TermNumber"           => "8585260000",
          "TransDate"            => "2013-12-01T00:00:00",
          "TransTypeCode"        => "010101",
          "UnitType"             => "00",
          "Units"                => "1",
          "Zipcode"              => ""
        }
      ],
      "ResponseGroup"            => "03",
      "ResponseType"             => "D6",
      "ReturnFileCode"           => "0",
      "TotalRevenue"             => "40",
      "ValidationKey"            => suretax_key
    }
  end

  def valid_test_response_body
    {
      "Successful"     => "Y",
      "ResponseCode"   => "9999",
      "HeaderMessage"  => "Success",
      "ItemMessages"   => [],
      "ClientTracking" => "track",
      "TotalTax"       => "1.394490",
      "TransId"        => 2664495,
      "GroupList"      => [
        {
          "StateCode"      => "CA",
          "InvoiceNumber"  => "1",
          "CustomerNumber" => "000000007",
          "TaxList"        => [
            {
              "TaxTypeCode" => "106",
              "TaxTypeDesc" => "CA EMERG TEL. USERS SURCHARGE",
              "TaxAmount"   => "0.200760"
            },
            {
              "TaxTypeCode" => "108",
              "TaxTypeDesc" => "CA P.U.C. FEE",
              "TaxAmount"   => "0.072130"
            },
            {
              "TaxTypeCode" => "109",
              "TaxTypeDesc" => "CA TELECOM RELAY SYSTEMS SURCHARGE",
              "TaxAmount"   => "0.080000"
            },
            {
              "TaxTypeCode" => "117",
              "TaxTypeDesc" => "CA HIGH COST FUND(B) SURCHARGE",
              "TaxAmount"   => "0.120000"
            },
            {
              "TaxTypeCode" => "118",
              "TaxTypeDesc" => "CA TELECONNECT FUND",
              "TaxAmount"   => "0.236000"
            },
            {
              "TaxTypeCode" => "119",
              "TaxTypeDesc" => "CA HIGH COST FUND(A) SURCHARGE",
              "TaxAmount"   => "0.160000"
            },
            {
              "TaxTypeCode" => "120",
              "TaxTypeDesc" => "CA ADVANCED SERV FUND SURCH",
              "TaxAmount"   => "0.065600"
            },
            {
              "TaxTypeCode" => "122",
              "TaxTypeDesc" => "CA UNIVERSAL LIFELINE  SURCHARGE",
              "TaxAmount"   => "0.460000"
            }
          ]
        }
      ]
    }
  end

  def valid_v03_response_body
    {
      "Successful" => "Y",
      "ResponseCode" => "9999",
      "HeaderMessage" => "Success",
      "ItemMessages" => [],
      "ClientTracking" => "track",
      "TotalTax" => "1.394490",
      "TransId" => 2872159,
      "GroupList" => [
        {
        "LineNumber" => "1",
        "StateCode" => "CA",
        "InvoiceNumber" => "1",
        "CustomerNumber" => "000000007",
        "TaxList" => [
          {
            "TaxTypeCode" => "106",
            "TaxTypeDesc" => "CA EMERG TEL. USERS SURCHARGE",
            "TaxAmount" => "0.200760",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.005,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "108",
            "TaxTypeDesc" => "CA P.U.C. FEE",
            "TaxAmount" => "0.072130",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.0018,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "109",
            "TaxTypeDesc" => "CA TELECOM RELAY SYSTEMS SURCHARGE",
            "TaxAmount" => "0.080000",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.002,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "117",
            "TaxTypeDesc" => "CA HIGH COST FUND(B) SURCHARGE",
            "TaxAmount" => "0.120000",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.003,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "118",
            "TaxTypeDesc" => "CA TELECONNECT FUND",
            "TaxAmount" => "0.236000",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.0059,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "119",
            "TaxTypeDesc" => "CA HIGH COST FUND(A) SURCHARGE",
            "TaxAmount" => "0.160000",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.004,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "120",
            "TaxTypeDesc" => "CA ADVANCED SERV FUND SURCH",
            "TaxAmount" => "0.065600",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.00164,
            "PercentTaxable" => 1.0
          },
          {
            "TaxTypeCode" => "122",
            "TaxTypeDesc" => "CA UNIVERSAL LIFELINE  SURCHARGE",
            "TaxAmount" => "0.460000",
            "Revenue" => "40",
            "CountyName" => "SAN DIEGO",
            "CityName" => "SAN DIEGO",
            "TaxRate" => 0.0115,
            "PercentTaxable" => 1.0
          }]
        }
      ]
    }
  end

  def valid_failure_response
    {
      "Successful"=>"N",
      "ResponseCode"=>"1101",
      "HeaderMessage"=>"Failure - Error parsing request",
      "ItemMessages"=>[],
      "ClientTracking"=>nil,
      "TotalTax"=>nil,
      "TransId"=>2667859,
      "GroupList"=>[]
    }
  end

  def success_with_item_errors
    {
      "Successful"       => "Y",
      "ResponseCode"     => "9001",
      "HeaderMessage"    => "Success with Item errors",
      "ItemMessages"     => [
        {
          "LineNumber"   => "1",
          "ResponseCode" => "9220",
          "Message"      => "Invalid Unit Type – Must be 00"
        }
      ],
      "ClientTracking"   => "7310",
      "TotalTax"         => "26.53",
      "TransId"          => 4366,
      "GroupList"        => [
        {
          "CustomerNumber" => "00123",
          "InvoiceNumber"  => "12345678",
          "StateCode"      => "CA",
          "TaxList"        => [
            {
              "TaxAmount"   => "10.45",
              "TaxTypeCode" => "316",
              "TaxTypeDesc" => "LOCAL UTILITY USERS TAX"
            },
            {
              "TaxAmount"   => "15.50",
              "TaxTypeCode" => "035",
              "TaxTypeDesc" => "FEDERAL UNIVERSAL SERVICE FUND"
            },
            {
              "TaxAmount"   => "0.58",
              "TaxTypeCode" => "060",
              "TaxTypeDesc" => "FEDERAL TRS FUND"
            }
          ]
        }
      ]
    }
  end

  def suretax_valid_request_params
    {
       business_unit: "testing",
       client_number: suretax_client_number,
       client_tracking: "track",
       data_month: "7",
       data_year: "2013",
       industry_exemption: "",
       response_group: "03",
       response_type: "D6",
       return_file_code: "0",
       total_revenue: "40",
       validation_key: suretax_key,
       items: [ suretax_valid_request_item_params ]
    }
  end

  def suretax_valid_request_item_params
    {
      bill_to_number: "8585260000",
      customer_number: "000000007",
      invoice_number: "1",
      line_number: "1",
      orig_number: "8585260000",
      p_to_p_plus_four: "",
      p_to_p_zipcode: "",
      plus_four: "",
      regulatory_code: "99",
      revenue: "40",
      sales_type_code: "R",
      seconds: "55",
      tax_included_code: "0",
      tax_situs_rule: "01",
      term_number: "8585260000",
      trans_date: "2013-12-01T00:00:00",
      trans_type_code: "010101",
      unit_type: "00",
      units: "1",
      zipcode: "",
      tax_exemption_codes: [ "00", "00" ]
    }
  end

end
