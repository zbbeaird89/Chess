class Game
  attr_reader :board, :players, :player1, :player2
  attr_accessor :current_player, :other_player

  def initialize(input)
    @players        = input.fetch(:players)
    @player1        = @players[0]
    @player2        = @players[1]
    @current_player = @player1
    @other_player   = @player2
    @board          = Board.new
    assign_pieces
    board.track_pieces
  end

  def play
    #until game_over?
    board.all_moves
    loop do

      input = solicit_move

      snap_shot = [{input[0] => board.squares[input[0]].value},
                   {input[1] => board.squares[input[1]].value}]

      initiate_move(input) #["A3", "A4"]

      if in_check?
        #reverts grid to what it looked like before player moved
        revert(snap_shot)
        puts "That is an illegal move. Please choose another move."
        puts ""
      else
        board.all_moves
        switch_players
      end
    end
  end

  #TODO game_over? method and checkmate and stalemate methods
  #checkmate will loop through board.kings and check if sq.attacked? and
  #if king.moves.empty?


  #TODO write castle method

  private

    #returns true if move was successful
    #returns false if move causes current_player king to be in check
    def initiate_move(input)
      from_sq = board.squares[input[0]]
      to_sq   = board.squares[input[1]]

      piece = from_sq.value

      piece.move(to_sq)
    end

    def solicit_move
      board.formatted_grid

      puts "It's #{@current_player.name}'s turn."

      start_sq = gets.chomp
      end_sq   = gets.chomp

      start_sq[0] = start_sq[0].upcase
      end_sq[0]   = end_sq[0].upcase

      if legal_move?(start_sq, end_sq)
        return [start_sq, end_sq]
      else
        puts "There was a legal move that was attempted. Please select"
        puts "a different move."
        solicit_move
      end
    end

    def legal_move?(start_sq, end_sq)

      #Check for correct notation
      return false if !correct_notation?(start_sq, end_sq)

      start_sq = board.squares[start_sq]
      end_sq   = board.squares[end_sq]

      unless start_sq.value.is_a?(Piece) && start_sq.value.color == @current_player.color
        return false
      end

      if start_sq.value.moves.include?(end_sq)
        if end_sq.value.is_a?(Piece)
          if end_sq.value.color == @current_player.color
            puts "You can't attack your own pieces!"
            return false
          end
        end
      else
        puts "Can't move there!"
        return false
      end

      return true
    end

    def correct_notation?(start_sq, end_sq)
      [start_sq, end_sq].each do |sq|
        unless letter?(sq[0]) || number?(sq[1])
          puts "Incorrect Notation!"
          return false
        end
      end
    end

    def letter?(input)
      input =~ /[A-Ha-h]/
    end

    def number?(input)
      input =~ /[1-8]/
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def in_check?
      #loop through both kings
      current_player_king = board.kings.select { |king| king.color == @current_player.color  }[0]

      #find coordinates of king's square
      y, x = board.grid.coordinates(current_player_king.square)
      #return true if it is in trouble
      return true if current_player_king.check?(y, x)
      #return false if it is not in trouble
      return false
    end

    def revert(snapshot)
      snapshot[0].each { |sq, piece| board.squares[sq].value = piece  }
      snapshot[1].each { |sq, piece| board.squares[sq].value = piece  }
    end

    def assign_pieces
      #Links all instances of Piece to the grid
      Piece.link_to_grid(board.grid)

      #Assigns White pieces to their starting squares
      board.squares["A1"].value = Rook.new(:square => board.squares["A1"],
                                           :player => player1,
                                           :color  => player1.color)

      board.squares["B1"].value = Knight.new(:square => board.squares["B1"],
                                             :player => player1,
                                             :color  => player1.color)

      board.squares["C1"].value = Bishop.new(:square => board.squares["C1"],
                                             :player => player1,
                                             :color  => player1.color)

      board.squares["D1"].value = Queen.new(:square => board.squares["D1"],
                                            :player => player1,
                                            :color  => player1.color)

      board.squares["E1"].value = King.new(:square => board.squares["E1"],
                                           :player => player1,
                                           :color  => player1.color)

      board.squares["F1"].value = Bishop.new(:square => board.squares["F1"],
                                             :player => player1,
                                             :color  => player1.color)

      board.squares["G1"].value = Knight.new(:square => board.squares["G1"],
                                             :player => player1,
                                             :color  => player1.color)

      board.squares["H1"].value = Rook.new(:square => board.squares["H1"],
                                           :player => player1,
                                           :color  => player1.color)

      #Assigns White Pawns
      ("A".."H").each do |letter|
        board.squares[letter + "2"].value = Pawn.new(:square => board.squares[letter + "2"],
                                                     :player => player1,
                                                     :color  => player1.color)
      end

      #Assigns Black pieces to starting squares
      board.squares["A8"].value = Rook.new(:square => board.squares["A8"],
                                           :player => player2,
                                           :color  => player2.color)

      board.squares["B8"].value = Knight.new(:square => board.squares["B8"],
                                             :player => player2,
                                             :color  => player2.color)

      board.squares["C8"].value = Bishop.new(:square => board.squares["C8"],
                                             :player => player2,
                                             :color  => player2.color)

      board.squares["D8"].value = Queen.new(:square => board.squares["D8"],
                                            :player => player2,
                                            :color  => player2.color)

      board.squares["E8"].value = King.new(:square => board.squares["E8"],
                                           :player => player2,
                                           :color  => player2.color)

      board.squares["F8"].value = Bishop.new(:square => board.squares["F8"],
                                             :player => player2,
                                             :color  => player2.color)

      board.squares["G8"].value = Knight.new(:square => board.squares["G8"],
                                             :player => player2,
                                             :color  => player2.color)

      board.squares["H8"].value = Rook.new(:square => board.squares["H8"],
                                           :player => player2,
                                           :color  => player2.color)

      #Assigns Black Pawns
      ("A".."H").each do |letter|
        board.squares[letter + "7"].value = Pawn.new(:square => board.squares[letter + "7"],
                                                     :player => player2,
                                                     :color  => player2.color)
      end
    end
end
