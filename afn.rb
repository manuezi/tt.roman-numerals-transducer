require "roman-numerals"

class RomanNumeralTransducer
  def initialize(word, debug_mode = false)
      @word = word.upcase()
      @idx = 0
      @output_tape = []
      @decimal = 0
      @debug_mode = debug_mode
  end

  def next_symbol
    if @idx == @word.size
        return ""
    else
        return @word[@idx]
    end
  end

  def set_word(word)
    @word = word
    @idx = 0
    @decimal = 0
    @output_tape = []
  end
  
  def start
    state = "q0"
    output = 0

    if @debug_mode
      puts("Máquina iniciou no estado: " + state)
    end
  
    loop do
      case [next_symbol, state]
      # Units
      in ["I", "q0"]
        state = "I1"
        output = 1
      in ["I", "I1"]
        state = "I2"
        output = 1
      in ["I", "I2"]
        state = "I3"
        output = 1
      in ["V", "I1"]
        state = "IV"
        output = 3
      in ["X", "I1"]
        state = "IX"
        output = 8
      in ["V", "q0"]
        state = "V"
        output = 5
      in ["I", "V"]
        state = "VI"
        output = 1
      in ["I", "VI"]
        state = "I2"
        output = 1

      # Tens
      in ["X", "q0"]
        state = "X1"
        output = 10
      in ["X", "X1"]
        state = "X2"
        output = 10
      in ["X", "X2"]
        state = "X3"
        output = 10
      in ["I", "X1" | "X2" | "X3" | "XL" | "XC"]
        state = "I1"
        output = 1
      in ["V", "X1" | "X2" | "X3" | "XL" | "XC"]
        state = "V"
        output = 5
      in ["L", "X1"]
        state = "XL"
        output = 30
      in ["C", "X1"]
        state = "XC"
        output = 80
      in ["L", "q0"]
        state = "L"
        output = 50
      in ["I", "L" | "LX"]
        state = "I1"
        output = 1
      in ["V", "L" | "LX"]
        state = "V"
        output = 5
      in ["X", "L"]
        state = "LX"
        output = 10
      in ["X", "LX"]
        state = "X2"
        output = 10

      # Hundreds
      in ["C", "q0"]
        state = "C1"
        output = 100
      in ["C", "C1"]
        state = "C2"
        output = 100
      in ["C", "C2"]
        state = "C3"
        output = 100
      in ["I", "C1" | "C2" | "C3" | "CD" | "CM"]
        state = "I1"
        output = 1
      in ["V", "C1" | "C2" | "C3" | "CD" | "CM"]
        state = "V"
        output = 5
      in ["X", "C1" | "C2" | "C3" | "CD" | "CM"]
        state = "X1"
        output = 10
      in ["L", "C1" | "C2" | "C3" | "CD" | "CM"]
        state = "L"
        output = 50
      in ["D", "C1"]
        state = "CD"
        output = 300
      in ["M", "C1"]
        state = "CM"
        output = 800
      in ["D", "q0"]
        state = "D"
        output = 500
      in ["I", "D" | "DC"]
        state = "I1"
        output = 1
      in ["V", "D" | "DC"]
        state = "V"
        output = 5
      in ["X", "D" | "DC"]
        state = "X1"
        output = 10
      in ["L", "D" | "DC"]
        state = "L"
        output = 50
      in ["C", "D"]
        state = "DC"
        output = 100
      in ["C", "DC"]
        state = "C2"
        output = 100

      # Thousands
      in ["M", "q0"]
        state = "M1"
        output = 1000
      in ["M", "M1"]
        state = "M2"
        output = 1000
      in ["M", "M2"]
        state = "M3"
        output = 1000
      in ["I", "M1" | "M2" | "M3"]
        state = "I1"
        output = 1
      in ["V", "M1" | "M2" | "M3"]
        state = "V"
        output = 5
      in ["X", "M1" | "M2" | "M3"]
        state = "X1"
        output = 10
      in ["L", "M1" | "M2" | "M3"]
        state = "L"
        output = 50
      in ["C", "M1" | "M2" | "M3"]
        state = "C1"
        output = 100
      in ["D", "M1" | "M2" | "M3"]
        state = "D"
        output = 500
      in ["", "I1" | "I2" | "I3" | "IV" | "IX" | "V" | "VI" | "X1" | "X2" | "X3" | "XL" | "XC" | "L" | "LX" | "C1" | "C2" | "C3" | "CD" | "CM" | "D" | "DC" | "M1" | "M2" | "M3"]
        if @debug_mode
          puts("Aceito 😀")
        end
        break
      else
        if @debug_mode
          puts("Erro")
        end
        break
      end
  
      @idx += 1
      @decimal += output
      @output_tape.push(output) if @output_tape

      if @debug_mode
        puts("Máquina atualizou para o estado: " + state)
        puts("Decimal acumulado: " + @decimal.to_s)
      end
    end

    return @output_tape
  end
end

if __FILE__ == $0
  puts "\n--- Iniciando Bateria de Testes (1 até 3999) ---"
  transducer = RomanNumeralTransducer.new("I", true)
  errors = 0

  (1..3999).each do |expected|
    romano = RomanNumerals.to_roman(expected)
    
    transducer.set_word(romano)
    result = transducer.start() 
    
    if result.sum != expected
      puts "FALHOU: #{romano} | Esperado: #{expected} | Obtido: #{result.sum}"
      errors += 1
    else
      puts "SUCESSO: #{romano} | Esperado: #{expected} | Obtido: #{result.sum}"
    end
  end

  if errors == 0
    puts "SUCESSO ABSOLUTO: O Autômato converteu todos os 3999 números corretamente! 🚀"
  else
    puts "Deu ruim. Tivemos #{errors} erros. Verifique os logs acima."
  end
end
