FactoryBot.define do

  factory :address do
    last_name              { "久保田" }
    first_name             { "一鷹" }
    last_name_kana         { "クボタ" }
    first_name_kana        { "カズタカ" }
    postal_code            { "411-5599" }
    region                 { "岩手県" }
    city                   { "金ケ崎町" }
    street                 { "西根南町22-1" }
    building               { "金ケ崎町役場3A" }
    phone_number           { "070-6543-9910" }
  end

end