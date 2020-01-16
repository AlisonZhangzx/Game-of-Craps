/*
 File: Extension_version_1.t
 Name: Alison Zhang
 Class: ICS2O1
 */
setscreen ("graphics")
const WIN := "win"      %
const LOSE := "lose"    % constants for status of winning or losing
const UK := "unknown"   %
var num1, num2, sum1, sum2 : int  % the rolled number and their sum for roll1 and roll2
var input : string  % user input
var x, y, bnum, bud : int  %%% for mouse control
var status1, status2 : string  %%% player1 and player2's winning or losin statuses
num2 := 0
status1 := UK
status2 := UK
%%%%% extensions
var line : int := 149 % animation at the end
var clr_start : int := 56 %%% color animation for the title on the welcome page
var player1, player2 : string  %%% player name
var clr1, clr2, clr3 : int %%% theme colors
var game_count, win1_count, win2_count := 0 %%% game count and win counts(for both players)
var num_player, font1, font2, font3, font4, font5, font6 : int  %%% player number and fonts
font1 := Font.New ("lithos pro regular:60:bold")
font2 := Font.New ("lithos pro regular:30:bold")
font3 := Font.New ("lithos pro regular:25:bold")
font4 := Font.New ("lithos pro regular:20:bold")
font5 := Font.New ("lithos pro regular:15:bold")
font6 := Font.New ("lithos pro regular:15")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Welcome page animation
drawfillbox (0, 0, maxx, maxy, 57)
delay (300)
loop
    Font.Draw ("Welcome to the game of Craps", 50, 250, font3, clr_start)
    clr_start := clr_start + 1
    exit when (clr_start = 103)
    delay (30)
end loop
Font.Draw ("Welcome to the game of Craps", 50, 250, font3, 0)

%%% wait for a mouse click (the word changes color when the mouse is on it, with or without clicking)
drawfillbox (477, 5, 630, 45, 0)
Font.Draw ("continue", 480, 15, font4, 57)
loop
    Mouse.Where (x, y, bud)
    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
	Font.Draw ("continue", 480, 15, font4, 80)
    else
	Font.Draw ("continue", 480, 15, font4, 57)
    end if
    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
end loop
delay (100) % the delay is necessary, or the program will be too fast and there's no time for user to react


% instructions page
cls
drawfillbox (0, 0, maxx, maxy, 57)
Font.Draw ("Here are the instructions: ", 10, 370, font3, 0)
Font.Draw ("You roll two dice. On the first roll of a game", 25, 350, font6, 0)
Font.Draw ("If the sum of the dice is:", 25, 325, font6, 0)
drawfilloval (40, 308, 3, 3, 0)
Font.Draw ("2, 3 or 12, you lose", 50, 300, font6, 0)
drawfilloval (40, 283, 3, 3, 0)
Font.Draw ("7 or 11, you win", 50, 275, font6, 0)
drawfilloval (40, 258, 3, 3, 0)
Font.Draw ("If you roll any other sum, this is called your point", 50, 250, font6, 0)
Font.Draw ("and you keep rolling.", 50, 225, font6, 0)
Font.Draw ("On subsequent rolls if you:", 25, 200, font6, 0)
drawfilloval (40, 183, 3, 3, 0)
Font.Draw ("get your point again, you win", 50, 175, font6, 0)
drawfilloval (40, 158, 3, 3, 0)
Font.Draw ("roll a 7, you lose", 50, 150, font6, 0)
drawfilloval (40, 133, 3, 3, 0)
Font.Draw ("Keep rolling until you get your point or a 7", 50, 125, font6, 0)

%%% wait for a mouse click
drawfillbox (477, 5, 630, 45, 0)
Font.Draw ("continue", 480, 15, font4, 57)
loop
    Mouse.Where (x, y, bud)
    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
	Font.Draw ("continue", 480, 15, font4, 80)
    else
	Font.Draw ("continue", 480, 15, font4, 57)
    end if
    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
end loop

%%% ask the user for number of players
loop
    cls
    Font.Draw ("Select the number of players", 80, 290, font4, 57)
    drawfillbox (77, 200, 215, 240, 57)
    Font.Draw ("1 player", 80, 210, font4, 0)
    drawfillbox (377, 200, 530, 240, 57)
    Font.Draw ("2 players", 380, 210, font4, 0)

    %%% mouse click
    loop
	Mouse.Where (x, y, bud)
	if (x >= 77 and x <= 215 and y >= 200 and y <= 240) then
	    Font.Draw ("1 player", 80, 210, font4, 80)
	elsif (x >= 377 and x <= 530 and y >= 200 and y <= 240) then
	    Font.Draw ("2 players", 380, 210, font4, 80)
	else
	    Font.Draw ("1 player", 80, 210, font4, 0)
	    Font.Draw ("2 players", 380, 210, font4, 0)
	end if
	exit when (x >= 77 and x <= 215 and y >= 200 and y <= 240 or x >= 377 and x <= 530 and y >= 200 and y <= 240) and (bud = 1)
    end loop

    %%% generate the number of players according to the clicked button
    if (x >= 77 and x <= 215 and y >= 200 and y <= 240) then
	num_player := 1
    elsif (x >= 377 and x <= 530 and y >= 200 and y <= 240) then
	num_player := 2
    end if

    %%% ask for players' names
    if (num_player = 2) then
	cls
	drawfillbox (0, 210, maxx, 230, 78)
	drawfillbox (0, 210, maxx, 190, 68)
	Text.Locate (10, 1)
	put "\tEnter the name of player 1: " ..
	get player1
	Text.Locate (15, 1)
	put "\tEnter the name of player 2: " ..
	get player2
    end if
    % game starts
    loop
	%%% game count
	game_count := game_count + 1

	for a : 1 .. num_player
	    %%% display player's name in the themed color (for double player mode only, blue for player1 and yellow for player2)
	    cls
	    if (num_player = 2 and a = 1) then
		clr1 := 78
		clr2 := 76
		clr3 := 11
		drawfillbox (220, 250, 430, 300, 78)
		Font.Draw ("player 1", 230, 260, font2, 0)
		Text.Locate (11, 1)
		Font.Draw (player1 + "'s turn:", 200, 200, font3, clr1)
	    elsif (num_player = 2 and a = 2) then
		clr1 := 67
		clr2 := 68
		clr3 := 14
		drawfillbox (220, 250, 430, 300, 67)
		Font.Draw ("player 2", 230, 260, font2, 0)
		Text.Locate (11, 1)
		Font.Draw (player2 + "'s turn:", 200, 200, font3, clr1)
	    else
		clr1 := 57
		clr2 := 80
		clr3 := 13
	    end if

	    %%% additional confirmation button for double player mode
	    if (num_player = 2) then
		drawfillbox (477, 5, 630, 45, clr1)
		Font.Draw ("continue", 480, 15, font4, 0)
		loop
		    Mouse.Where (x, y, bud)
		    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			Font.Draw ("continue", 480, 15, font4, clr2)
		    else
			Font.Draw ("continue", 480, 15, font4, 0)
		    end if
		    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45 and bud = 1)
		end loop
	    end if

	    % get into the first round
	    randint (num1, 1, 6)
	    randint (num2, 1, 6)

	    %%% display rolling die1
	    cls
	    for i : 1 .. 4
		drawfillbox (30, 280, 130, 380, clr3)
		delay (30)
		drawfillbox (30, 280, 130, 380, clr2)
		delay (30)
		drawfillbox (30, 280, 130, 380, clr1)
		delay (30)
	    end for

	    %%% graphic of die1 result
	    case num1 of
		label 1 :
		    drawfilloval (80, 330, 10, 10, 7)
		label 2 :
		    drawfilloval (60, 310, 10, 10, 7)
		    drawfilloval (100, 350, 10, 10, 7)
		label 3 :
		    drawfilloval (50, 300, 10, 10, 7)
		    drawfilloval (80, 330, 10, 10, 7)
		    drawfilloval (110, 360, 10, 10, 7)
		label 4 :
		    drawfilloval (50, 300, 10, 10, 7)
		    drawfilloval (50, 360, 10, 10, 7)
		    drawfilloval (110, 360, 10, 10, 7)
		    drawfilloval (110, 300, 10, 10, 7)
		label 5 :
		    drawfilloval (50, 300, 10, 10, 7)
		    drawfilloval (50, 360, 10, 10, 7)
		    drawfilloval (110, 360, 10, 10, 7)
		    drawfilloval (110, 300, 10, 10, 7)
		    drawfilloval (80, 330, 10, 10, 7)
		label 6 :
		    drawfilloval (50, 300, 10, 10, 7)
		    drawfilloval (50, 330, 10, 10, 7)
		    drawfilloval (50, 360, 10, 10, 7)
		    drawfilloval (110, 360, 10, 10, 7)
		    drawfilloval (110, 330, 10, 10, 7)
		    drawfilloval (110, 300, 10, 10, 7)
	    end case

	    %%% display rolling die2
	    for i : 1 .. 5
		drawfillbox (160, 280, 260, 380, clr3)
		delay (30)
		drawfillbox (160, 280, 260, 380, clr2)
		delay (30)
		drawfillbox (160, 280, 260, 380, clr1)
		delay (30)
	    end for

	    %%% graphic of die2 result
	    case num2 of
		label 1 :
		    drawfilloval (210, 330, 10, 10, 7)
		label 2 :
		    drawfilloval (190, 310, 10, 10, 7)
		    drawfilloval (230, 350, 10, 10, 7)
		label 3 :
		    drawfilloval (180, 300, 10, 10, 7)
		    drawfilloval (210, 330, 10, 10, 7)
		    drawfilloval (240, 360, 10, 10, 7)
		label 4 :
		    drawfilloval (180, 300, 10, 10, 7)
		    drawfilloval (180, 360, 10, 10, 7)
		    drawfilloval (240, 360, 10, 10, 7)
		    drawfilloval (240, 300, 10, 10, 7)
		label 5 :
		    drawfilloval (180, 300, 10, 10, 7)
		    drawfilloval (180, 360, 10, 10, 7)
		    drawfilloval (240, 360, 10, 10, 7)
		    drawfilloval (240, 300, 10, 10, 7)
		    drawfilloval (210, 330, 10, 10, 7)
		label 6 :
		    drawfilloval (180, 300, 10, 10, 7)
		    drawfilloval (180, 330, 10, 10, 7)
		    drawfilloval (180, 360, 10, 10, 7)
		    drawfilloval (240, 360, 10, 10, 7)
		    drawfilloval (240, 330, 10, 10, 7)
		    drawfilloval (240, 300, 10, 10, 7)
	    end case

	    % display points in words
	    Text.Locate (10, 1)
	    put "Die 1: ", num1
	    delay (100)
	    put "Die 2: ", num2
	    sum1 := num1 + num2
	    put "sum: ", sum1

	    % check status of winning or losing
	    case sum1 of
		label 7, 11 : % win
		    if (a = 1) then
			status1 := WIN
		    else
			status2 := WIN
		    end if

		    put "You roll a sum of ", sum1, " in your first roll. You win!!"

		    %%% mouse click
		    drawfillbox (477, 5, 630, 45, clr1)
		    Font.Draw ("continue", 480, 15, font4, 0)
		    loop
			Mouse.Where (x, y, bud)
			if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			    Font.Draw ("continue", 480, 15, font4, clr2)
			else
			    Font.Draw ("continue", 480, 15, font4, 0)
			end if
			exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45 and bud = 1)
		    end loop

		label 2, 3, 12 : % lose
		    if (a = 1) then
			status1 := LOSE
		    else
			status2 := LOSE
		    end if

		    put "You roll a sum of ", sum1, " in your first roll. You lose!!"

		    %%% mouse click
		    drawfillbox (477, 5, 630, 45, clr1)
		    Font.Draw ("continue", 480, 15, font4, 0)
		    loop
			Mouse.Where (x, y, bud)
			if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			    Font.Draw ("continue", 480, 15, font4, clr2)
			else
			    Font.Draw ("continue", 480, 15, font4, 0)
			end if
			exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45 and bud = 1)
		    end loop

		label : % not known status for winning or losing
		    if (a = 1) then
			status1 := UK
		    else
			status2 := UK
		    end if

		    put "Your point from your first roll is ", sum1
		    put "Since you just rolled a(n) ", sum1, " you can roll again to try to get another ", sum1, " to win"

		    %%% mouse click
		    drawfillbox (10, 5, 80, 45, clr1)
		    Font.Draw ("exit", 13, 15, font4, 0)
		    drawfillbox (455, 5, 630, 45, clr1)
		    Font.Draw ("roll again", 458, 15, font4, 0)
		    loop
			Mouse.Where (x, y, bud)
			if (x >= 10 and x <= 80 and y >= 5 and y <= 45) then
			    Font.Draw ("exit", 13, 15, font4, clr2)
			elsif (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			    Font.Draw ("roll again", 458, 15, font4, clr2)
			else
			    Font.Draw ("exit", 13, 15, font4, 0)
			    Font.Draw ("roll again", 458, 15, font4, 0)
			end if
			exit when (x >= 10 and x <= 80 and y >= 5 and y <= 45 or x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
		    end loop

		    %%% generate input from the button the user clicks on(input of "o" for exit, input of "c" for continue)
		    if (x >= 10 and x <= 80 and y >= 5 and y <= 45) then
			input := "o"
		    elsif (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			input := "c"
		    end if

		    if (input = "c") then
			% get into second round
			loop
			    % get numbers again
			    randint (num1, 1, 6)
			    randint (num2, 1, 6)

			    %%% display rolling die1
			    cls
			    for i : 1 .. 4
				drawfillbox (30, 280, 130, 380, clr3)
				delay (30)
				drawfillbox (30, 280, 130, 380, clr2)
				delay (30)
				drawfillbox (30, 280, 130, 380, clr1)
				delay (30)
			    end for

			    %%% graphic of die1 result
			    case num1 of
				label 1 :
				    drawfilloval (80, 330, 10, 10, 7)
				label 2 :
				    drawfilloval (60, 310, 10, 10, 7)
				    drawfilloval (100, 350, 10, 10, 7)
				label 3 :
				    drawfilloval (50, 300, 10, 10, 7)
				    drawfilloval (80, 330, 10, 10, 7)
				    drawfilloval (110, 360, 10, 10, 7)
				label 4 :
				    drawfilloval (50, 300, 10, 10, 7)
				    drawfilloval (50, 360, 10, 10, 7)
				    drawfilloval (110, 360, 10, 10, 7)
				    drawfilloval (110, 300, 10, 10, 7)
				label 5 :
				    drawfilloval (50, 300, 10, 10, 7)
				    drawfilloval (50, 360, 10, 10, 7)
				    drawfilloval (110, 360, 10, 10, 7)
				    drawfilloval (110, 300, 10, 10, 7)
				    drawfilloval (80, 330, 10, 10, 7)
				label 6 :
				    drawfilloval (50, 300, 10, 10, 7)
				    drawfilloval (50, 330, 10, 10, 7)
				    drawfilloval (50, 360, 10, 10, 7)
				    drawfilloval (110, 360, 10, 10, 7)
				    drawfilloval (110, 330, 10, 10, 7)
				    drawfilloval (110, 300, 10, 10, 7)
			    end case

			    %%% display rolling die2
			    for i : 1 .. 5
				drawfillbox (160, 280, 260, 380, clr3)
				delay (30)
				drawfillbox (160, 280, 260, 380, clr2)
				delay (30)
				drawfillbox (160, 280, 260, 380, clr1)
				delay (30)
			    end for

			    %%% graphic of die2 result
			    case num2 of
				label 1 :
				    drawfilloval (210, 330, 10, 10, 7)
				label 2 :
				    drawfilloval (190, 310, 10, 10, 7)
				    drawfilloval (230, 350, 10, 10, 7)
				label 3 :
				    drawfilloval (180, 300, 10, 10, 7)
				    drawfilloval (210, 330, 10, 10, 7)
				    drawfilloval (240, 360, 10, 10, 7)
				label 4 :
				    drawfilloval (180, 300, 10, 10, 7)
				    drawfilloval (180, 360, 10, 10, 7)
				    drawfilloval (240, 360, 10, 10, 7)
				    drawfilloval (240, 300, 10, 10, 7)
				label 5 :
				    drawfilloval (180, 300, 10, 10, 7)
				    drawfilloval (180, 360, 10, 10, 7)
				    drawfilloval (240, 360, 10, 10, 7)
				    drawfilloval (240, 300, 10, 10, 7)
				    drawfilloval (210, 330, 10, 10, 7)
				label 6 :
				    drawfilloval (180, 300, 10, 10, 7)
				    drawfilloval (180, 330, 10, 10, 7)
				    drawfilloval (180, 360, 10, 10, 7)
				    drawfilloval (240, 360, 10, 10, 7)
				    drawfilloval (240, 330, 10, 10, 7)
				    drawfilloval (240, 300, 10, 10, 7)
			    end case

			    % display points in words
			    Text.Locate (10, 1)
			    put "Die 1: ", num1
			    delay (100)
			    put "Die 2: ", num2
			    sum2 := num1 + num2
			    put "Sum: ", sum2

			    % check status of winning or losing
			    if (sum2 = sum1) then % win
				if (a = 1) then
				    status1 := WIN
				else
				    status2 := WIN
				end if

				put "You just rolled a ", sum2, " (the point). You win!!"

				%%% mouse click
				drawfillbox (477, 5, 630, 45, clr1)
				Font.Draw ("continue", 480, 15, font4, 0)
				loop
				    Mouse.Where (x, y, bud)
				    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
					Font.Draw ("continue", 480, 15, font4, clr2)
				    else
					Font.Draw ("continue", 480, 15, font4, 0)
				    end if
				    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
				end loop

			    elsif (sum2 = 7) then % lose
				if (a = 1) then
				    status1 := LOSE
				else
				    status2 := LOSE
				end if

				put "You just rolled a 7. You lose!!"

				%%% mouse click
				drawfillbox (477, 5, 630, 45, clr1)
				Font.Draw ("continue", 480, 15, font4, 0)
				loop
				    Mouse.Where (x, y, bud)
				    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
					Font.Draw ("continue", 480, 15, font4, clr2)
				    else
					Font.Draw ("continue", 480, 15, font4, 0)
				    end if
				    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
				end loop

			    else % not known status
				status1 := UK
				status2 := UK
				put "Your point from your first roll is ", sum1
				put "Since you just rolled a(n) ", sum1, " you can roll again to try to get another ", sum1, " to win"

				%%% mouse click
				drawfillbox (10, 5, 80, 45, clr1)
				Font.Draw ("exit", 13, 15, font4, 0)
				drawfillbox (455, 5, 630, 45, clr1)
				Font.Draw ("roll again", 458, 15, font4, 0)
				loop
				    Mouse.Where (x, y, bud)
				    if (x >= 10 and x <= 80 and y >= 5 and y <= 45) then
					Font.Draw ("exit", 13, 15, font4, clr2)
				    elsif (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
					Font.Draw ("roll again", 458, 15, font4, clr2)
				    else
					Font.Draw ("exit", 13, 15, font4, 0)
					Font.Draw ("roll again", 458, 15, font4, 0)
				    end if
				    exit when (x >= 10 and x <= 80 and y >= 5 and y <= 45 or x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
				end loop

				%%% generate user input according to the mouse click ("o" for exit, "c" for continue)
				if (x >= 10 and x <= 80 and y >= 5 and y <= 45) then
				    input := "o"
				elsif (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
				    input := "c"
				end if

			    end if
			    exit when (sum2 = sum1 or sum2 = 7 or input not= "c")
			end loop
		    end if
	    end case
	    delay (100)

	    % display win or lose in an outcoming screen
	    cls
	    if (status1 = WIN or status2 = WIN) then
		Font.Draw ("you win!", 125, 180, font1, clr1)
		if (status1 = WIN) then
		    win1_count := win1_count + 1
		else
		    win2_count := win2_count + 1
		end if

		%%% mouse click
		drawfillbox (477, 5, 630, 45, clr1)
		Font.Draw ("continue", 480, 15, font4, 0)
		loop
		    Mouse.Where (x, y, bud)
		    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			Font.Draw ("continue", 480, 15, font4, clr2)
		    else
			Font.Draw ("continue", 480, 15, font4, 0)
		    end if
		    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
		end loop

	    elsif (status1 = LOSE or status2 = LOSE) then
		Font.Draw ("you lose!", 125, 180, font1, clr1)

		%%% mouse click
		drawfillbox (477, 5, 630, 45, clr1)
		Font.Draw ("continue", 480, 15, font4, 0)
		loop
		    Mouse.Where (x, y, bud)
		    if (x >= 477 and x <= 630 and y >= 5 and y <= 45) then
			Font.Draw ("continue", 480, 15, font4, clr2)
		    else
			Font.Draw ("continue", 480, 15, font4, 0)
		    end if
		    exit when (x >= 477 and x <= 630 and y >= 5 and y <= 45) and (bud = 1)
		end loop
	    end if % there's no display of winning or losing if the user exits in the middle
	    %%% if the player1 exit in the middle of a double player mode game, the program will invite the second player to play

	    status1 := UK
	    status2 := UK
	    input := "o"
	    delay (100)
	end for

	% ending screen
	loop
	    cls
	    Font.Draw ("Your game has ended", 80, 300, font2, 57)

	    %%% display wins and games played
	    Font.Draw (intstr (game_count) + " games played, ", 5, 375, font6, 57)
	    if (num_player = 2) then
		Font.Draw (player1 + " won " + intstr (win1_count) + " times, " + player2 + " won " + intstr (win2_count) + " times", 5, 350, font6, 57)
	    else
		Font.Draw (intstr (win1_count) + " wins", 5, 350, font6, 57)
	    end if

	    %%% display comparision of two players
	    if (num_player = 2) then
		drawfillbox (0, 170, 320, 280, 78)
		drawfillbox (320, 170, 639, 280, 67)
		if (win1_count > win2_count) then
		    Font.Draw ("wins", 50, 200, font1, 0)
		    Font.Draw ("loses", 380, 200, font1, 0)
		elsif (win1_count < win2_count) then
		    Font.Draw ("loses", 50, 200, font1, 0)
		    Font.Draw ("wins", 380, 200, font1, 0)
		else
		    Font.Draw ("tie", 100, 200, font1, 0)
		    Font.Draw ("tie", 420, 200, font1, 0)
		end if
	    else
		drawfillbox (0, 170, maxx, 280, 57)
		Font.Draw ("game over", 100, 200, font1, 0)
	    end if

	    %%%% button options display
	    drawfillbox (10, 5, 80, 45, 57)
	    Font.Draw ("exit", 13, 15, font4, 0)
	    drawfillbox (225, 5, 408, 45, 57)
	    Font.Draw ("clear score", 228, 15, font4, 0)
	    drawfillbox (487, 5, 630, 45, 57)
	    Font.Draw ("reset all", 490, 15, font4, 0)
	    drawfillbox (77, 110, 310, 150, 57)
	    Font.Draw ("change player", 80, 120, font4, 0)
	    drawfillbox (377, 110, 550, 150, 57)
	    Font.Draw ("play again", 380, 120, font4, 0)

	    loop
		%%% mouse input
		Mouse.Where (x, y, bud)
		if (x >= 377 and x <= 550 and y >= 110 and y <= 150) then
		    Font.Draw ("play again", 380, 120, font4, 80)
		    input := "a"
		elsif (x >= 77 and x <= 310 and y >= 110 and y <= 150) then
		    Font.Draw ("change player", 80, 120, font4, 80) % switch between 1 player and 2 players mode
		    input := "c"
		elsif (x >= 10 and x <= 80 and y >= 5 and y <= 45) then
		    Font.Draw ("exit", 13, 15, font4, 80)
		    input := "e"
		elsif (x >= 225 and x <= 408 and y >= 5 and y <= 45) then
		    Font.Draw ("clear score", 228, 15, font4, 80) % only set the number of wins to 0
		    if (bud = 1) then
			input := "q"
			win1_count := 0
			win2_count := 0
		    end if
		elsif (x >= 487 and x <= 630 and y >= 5 and y <= 45) then
		    Font.Draw ("reset all", 490, 15, font4, 80) % set the number of wins and the number of games played to 0
		    if (bud = 1) then
			input := "r"
			win1_count := 0
			win2_count := 0
			game_count := 0
		    end if
		else %%% if the mouse is not on the buttons, the words remain white
		    Font.Draw ("exit", 13, 15, font4, 0)
		    Font.Draw ("clear score", 228, 15, font4, 0)
		    Font.Draw ("reset all", 490, 15, font4, 0)
		    Font.Draw ("change player", 80, 120, font4, 0)
		    Font.Draw ("play again", 380, 120, font4, 0)
		end if
		exit when (input = "a" or input = "c" or input = "e" or input = "q" or input = "r") and (bud = 1)
	    end loop

	    exit when (input = "a" or input = "c" or input = "e")
	end loop     %% the loop starting before "Your game has ended"
	exit when (input = "c" or input = "e")
    end loop      %% the loop starting before the for loop after entering player names (the game starts)
    exit when (input = "e")
end loop      %% the loop starting before select players

% exit screen animation
drawfillbox (0, 0, maxx, maxy, 57)
Font.Draw ("Thank you for playing", 60, 225, font2, 0)
Font.Draw ("A game by Alison Zhang", 150, 100, font4, 0)
delay (20)
loop
    drawfillbox (148, 97, line, 94, 0)
    line := line + 1
    delay (3)
    exit when (line = 528)
end loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
 possible bugs:
 if user hold the mouse for too long, the program will run over and over again at a rapid speed
 if switched from 1 player to 2 players mode, the previous score will be recorded in player1 (unless cleared or reseted)
 if the user clicked on a non-button area at the ending page after clicking on reset or clear, the program is going to refresh
 mouse conrol is not percise when clicking on edges of the boxes
 */
