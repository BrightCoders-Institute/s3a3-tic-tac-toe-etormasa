require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new(3, 3)
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @current_player = @player1
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def play
    loop do
      clear_screen
      @board.print_board
      puts "Es el turno del jugador #{@current_player.symbol}"

      puts "Ingrese la fila (0-2):"
      row = gets.chomp.to_i
      puts "Ingrese la columna (0-2):"
      col = gets.chomp.to_i

      if @board.make_move(row, col, @current_player.symbol)
        if @board.winner?(@current_player.symbol)
          clear_screen
          @board.print_board
          puts "¡El jugador #{@current_player.symbol} ha ganado!"
          break
        elsif @board.draw?
          clear_screen
          @board.print_board
          puts "El juego ha terminado en empate."
          break
        else
          switch_player
        end
      else
        puts "Movimiento no válido. Inténtalo de nuevo."
        gets # Esperar a que el usuario presione Enter antes de continuar
      end
    end
  end
end


