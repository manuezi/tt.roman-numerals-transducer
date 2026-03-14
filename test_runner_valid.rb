require_relative "roman_numerals_transducer"

valid_numerals = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX", "XXXI", "XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI", "XXXVII", "XXXVIII", "XXXIX", "XL", "XLI", "XLII", "XLIII", "XLIV", "XLV", "XLVI", "XLVII", "XLVIII", "XLIX", "L", "LI", "LII", "LIII", "LIV", "LV", "LVI", "LVII", "LVIII", "LIX", "LX", "LXI", "LXII", "LXIII", "LXIV", "LXV", "LXVI", "LXVII", "LXVIII", "LXIX", "LXX", "LXXI", "LXXII", "LXXIII", "LXXIV", "LXXV", "LXXVI", "LXXVII", "LXXVIII", "LXXIX", "LXXX", "LXXXI", "LXXXII", "C", "CC", "CCC", "CCCI", "CDI", "DCCX", "DCCCXLVIII", "CMIV", "M", "MDCLXVI", "MM", "MMM"]
transducer = RomanNumeralTransducer.new("")
errors = 0

valid_numerals.each do |roman|
  transducer.set_word(roman)
  result = transducer.start() 
  
  if result == nil
    puts("ERRO: #{roman}")
    errors += 1
  end
end

if errors == 0
  puts("SUCCESSO: Autômato converteu #{valid_numerals.size} números corretamente! 🚀")
else
  puts("#{errors} erros foram encontrados. Verifique os logs acima.")
end
