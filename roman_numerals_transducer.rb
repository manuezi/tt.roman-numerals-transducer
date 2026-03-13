class RomanNumeralTransducer
  def initialize(word)
    @word = word.upcase()
    @idx = 0
    @output_tape = []
  end

  def next_symbol
    if @idx == @word.size()
      return ""
    else
      return @word[@idx]
    end
  end

  def set_word(word)
    @word = word.upcase()
    @idx = 0
    @output_tape = []
  end
  
  def start
    curr_state = "q0"
  
    loop do
      symbol = next_symbol()
      next_state = "sink" # fallback
      output = 0

      case [symbol, curr_state]

      # --- THOUSANDS ---
      in ["M", "q0"]
        next_state = "M1"; output = 1000
      in ["M", "M1"]
        next_state = "M2"; output = 1000
      in ["M", "M2"]
        next_state = "M3"; output = 1000
      in ["I", "M1" | "M2" | "M3"]
        next_state = "I1"; output = 1
      in ["V", "M1" | "M2" | "M3"]
        next_state = "V"; output = 5
      in ["X", "M1" | "M2" | "M3"]
        next_state = "X1"; output = 10
      in ["L", "M1" | "M2" | "M3"]
        next_state = "L"; output = 50
      in ["C", "M1" | "M2" | "M3"]
        next_state = "C1"; output = 100
      in ["D", "M1" | "M2" | "M3"]
        next_state = "D"; output = 500

      # --- HUNDREDS ---
      in ["C", "q0"]
        next_state = "C1"; output = 100
      in ["C", "C1" | "DC"]
        next_state = "C2"; output = 100
      in ["C", "C2"]
        next_state = "C3"; output = 100
      in ["D", "q0"]
        next_state = "D"; output = 500
      in ["C", "D"]
        next_state = "DC"; output = 100
      in ["I", "C1" | "C2" | "C3" | "CD" | "CM" | "D" | "DC"]
        next_state = "I1"; output = 1
      in ["V", "C1" | "C2" | "C3" | "CD" | "CM" | "D" | "DC"]
        next_state = "V"; output = 5
      in ["X", "C1" | "C2" | "C3" | "CD" | "CM" | "D" | "DC"]
        next_state = "X1"; output = 10
      in ["L", "C1" | "C2" | "C3" | "CD" | "CM" | "D" | "DC"]
        next_state = "L"; output = 50

      # --- HUNDREDS (SUBTRACTIVE) ---
      in ["D", "C1"]
        next_state = "CD"; output = 300
      in ["M", "C1"]
        next_state = "CM"; output = 800

      # -- TENS ---
      in ["X", "q0"]
        next_state = "X1"; output = 10
      in ["X", "X1" | "LX"]
        next_state = "X2"; output = 10
      in ["X", "X2"]
        next_state = "X3"; output = 10
      in ["L", "q0"]
        next_state = "L"; output = 50
      in ["X", "L"]
        next_state = "LX"; output = 10
      in ["I", "X1" | "X2" | "X3" | "XL" | "XC" | "L" | "LX"]
        next_state = "I1"; output = 1
      in ["V", "X1" | "X2" | "X3" | "XL" | "XC" | "L" | "LX"]
        next_state = "V"; output = 5

      # --- TENS (SUBTRACTIVE) ---
      in ["L", "X1"]
        next_state = "XL"; output = 30
      in ["C", "X1"]
        next_state = "XC"; output = 80

      # --- UNITS ---
      in ["I", "q0"]
        next_state = "I1"; output = 1
      in ["I", "I1" | "VI"]
        next_state = "I2"; output = 1
      in ["I", "I2"]
        next_state = "I3"; output = 1
      in ["V", "q0"]
        next_state = "V"; output = 5
      in ["I", "V"]
        next_state = "VI"; output = 1

      # --- UNITS (SUBTRACTIVE) ---
      in ["V", "I1"]
        next_state = "IV"; output = 3
      in ["X", "I1"]
        next_state = "IX"; output = 8

      # --- FINAL STATE ---
      in ["", valid_state] if valid_state != "sink"
        return @output_tape
      else
        return nil
      end
  
      @output_tape.push(output)
      curr_state = next_state
      @idx += 1
    end
  end
end

if __FILE__ == $0
  puts("Running automaton in interactive mode...")
  transducer = RomanNumeralTransducer.new("")
  
  loop do
    puts("Enter a Roman numeral:")
    word = gets.chomp()
    
    transducer.set_word(word)
    result = transducer.start()

    if result != nil
      puts("Result: " + result.sum().to_s)
    else
      puts("Invalid input")
    end
  end
end
