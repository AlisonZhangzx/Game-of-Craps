setscreen ("graphics")

/*
 File: Extension_version_1.t
 Name: Alison Zhang
 Class: ICS2O1
 */
 
const WIN := "win"
const LOSE := "lose"
const UK := "unknown"
var num1, num2, sum1, sum2 : int  % the rolled number and their sum for roll1 and roll2
var input : string
var status : string := "unknown"
num2 := 0
%%% extension count for game played and wins, fonts
var game_count, win_count := 0
var font1, font2, font3, font4, font5, font6 : int
font1 := Font.New ("lithos pro regular:60:bold") 
font2 := Font.New ("lithos pro regular:30:bold") 
font3 := Font.New ("lithos pro regular:25:bold") 
font4 := Font.New ("lithos pro regular:20:bold") 
font5 := Font.New ("lithos pro regular:15:bold") 
font6 := Font.New ("lithos pro regular:15") 

% game starts
loop
  % Welcome page
  drawfillbox (0,0,maxx,maxy,57)
  Font.Draw ("Welcome to the game of Craps", 50, 250, font3, 0)
  Font.Draw ("Press any key to continue...", 150,210,font5,0) 
  Text.Locate (12,60)
  get input
  cls
  
  loop
    % instructions
    drawfillbox (0,0,maxx,maxy,57)
    Font.Draw ("Here is the instruction: ", 10,370,font3,0)
    Font.Draw ("You roll two dice. On the first roll of a game", 25,350,font6,0)
    Font.Draw ("If the sum of the dice is:", 25,325,font6,0)
    drawfilloval (40,308,3,3,0)
    Font.Draw ("2, 3 or 12, you lose", 50,300,font6,0)
    drawfilloval (40,283,3,3,0)
    Font.Draw ("7 or 11, you win", 50,275,font6,0)
    drawfilloval (40,258,3,3,0)
    Font.Draw ("If you roll any other sum, this is called your point", 50,250,font6,0)
    Font.Draw ("and you keep rolling.", 50,225,font6,0)
    Font.Draw ("On subsequent rolls if you:", 25,200,font6,0)
    drawfilloval (40,183,3,3,0)
    Font.Draw ("get your point again, you win", 50,175,font6,0)
    drawfilloval (40,158,3,3,0)
    Font.Draw ("roll a 7, you lose", 50,150,font6,0)
    drawfilloval (40,133,3,3,0)
    Font.Draw ("Keep rolling until you get your point or a 7", 50,125,font6,0)
    Font.Draw ("Press any key to continue...", 150,50,font6,0)
    Text.Locate (22,58)
    get input
    cls
    
    %%% extension game count
    game_count := game_count + 1
    
    % get the first round
    randint (num1, 1, 6)
    randint (num2, 1, 6)
    
    %%% display rolling die1
    for i : 1 .. 4
      drawfillbox (30, 280, 130, 380, 100)
      delay (30)
      drawfillbox (30, 280, 130, 380, 78)
      delay (30)
      drawfillbox (30, 280, 130, 380, 76)
      delay (30)
    end for
    
    %%% graphic of die1
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
      drawfillbox (160, 280, 260, 380, 100)
      delay (30)
      drawfillbox (160, 280, 260, 380, 78)
      delay (30)
      drawfillbox (160, 280, 260, 380, 76)
      delay (30)
   end for
   
   %%% graphic of die2
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
     
     % check status
     case sum1 of
       label 7, 11 :
	 status := WIN
	 put "You roll a sum of ", sum1, " in your first roll. You win!!"
	 put "Press any key to continue..." ..
	 get input
	 cls
       label 2, 3, 12 :
	 status := LOSE
	 put "You roll a sum of ", sum1, " in your first roll. You lose!!"
	 put "Press any key to continue..." ..
	 get input
	 cls
       label :
	 put "Your point from your first roll is ", sum1
	 put "Since you just rolled a(n) ", sum1, " you can roll again to try to get another ", sum1, " to win"
	 put "Press 'c' to continue, any other key to exit the game..." ..
	 get input
	 cls
	 if (input = "c") then
	 % get into second round
	 loop
	   % get numbers again
	   randint (num1, 1, 6)
	   randint (num2, 1, 6)
	   
	   %%% display rolling die1
	   for i : 1 .. 4
	     drawfillbox (30, 280, 130, 380, 100)
	     delay (30)
	     drawfillbox (30, 280, 130, 380, 78)
	     delay (30)
	     drawfillbox (30, 280, 130, 380, 76)
	     delay (30)
	   end for
	   
	  %%% graphic of die1
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
	      drawfillbox (160, 280, 260, 380, 100)
	      delay (30)
	      drawfillbox (160, 280, 260, 380, 78)
	      delay (30)
	      drawfillbox (160, 280, 260, 380, 76)
	      delay (30)
	    end for
	    
	    %%% graphic of die2
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
	  
	  % check status
	  if (sum2 = sum1) then
	    status := WIN
	    put "You just rolled a ", sum2, " (the point). You win!!"
	    put "Press any key to continue..." ..
	    get input
	    cls
	  elsif (sum2 = 7) then
	    status := LOSE
	    put "You just rolled a 7. You lose!!"
	    put "Press any key to continue..." ..
	    get input
	    cls
	  else
	    status := UK
	    put "Your point from your first roll is ", sum1
	    put "Since you just rolled a(n) ", sum1, " you can roll again to try to get another ", sum1, " to win"
	    put "Press 'c' to continue, any other key to exit the game..." ..
	    get input
	    cls
	end if
	exit when (sum2 = sum1 or sum2 = 7 or input not= "c")
	end loop
      end if
    end case
    
  % end of the game
  Font.Draw ("Your game has ended", 125, 300, font3, 57)
  if (status = WIN) then
    Font.Draw ("you win!", 125, 160, font1, 57)
    %%% extension number of wins
    win_count := win_count + 1
  elsif (status = LOSE) then
    Font.Draw ("you lost!", 125, 160, font1, 57)
  elsif (status = UK) then
    Font.Draw (" ", 0, 0, font3, 0)
  end if
  
  %%% extension display wins and games played
  put game_count, " games played, ", win_count, " wins."..
  Font.Draw ("Press 'c' to start a new game, any other key to exit...", 25, 100, font5, 57)
  get input
  cls
  exit when (input not= "c")
 end loop
 exit when (input not= "c")
end loop

% ending screen
drawfillbox (0,0,maxx,maxy,57)
Font.Draw ("Thank you for playing", 60, 225, font2, 0)
Font.Draw ("A game by Alison Zhang",150,100,font4,0)
