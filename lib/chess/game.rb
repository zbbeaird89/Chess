class Game  
  attr_reader :board, :players, :player1, :player2

  def initialize(input)
    @players = input.fetch(:players)
    @player1 = @players[0]
    @player2 = @players[1]
    @board   = Board.new
    assign_pieces
  end

  private

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