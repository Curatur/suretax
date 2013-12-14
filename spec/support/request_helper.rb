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

end
