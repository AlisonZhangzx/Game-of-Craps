setscreen("graphics")

/*
 File: Final_Project.t
 Name: Alison Zhang
 Class: ICS2O1
*/

const WIN:= "win"
const LOSE:= "lose"
const UK:= "unknown"
var num1, num2, sum1, sum2: int
var input: string
var status: string:= "unknown"
num2:= 0

loop
  loop
    % Welcome page
    cls
    put "Welcome to the game of Craps\n\nPress any key to continue..."..
    get input
    cls
    put "Here is the instruction: "
    put "You roll two dice. On the first roll of a game, if the sum of the dice is:" 
    put "2, 3 or 12, you lose" 
    put "7 or 11, you win"
    put "If you roll any other sum this is called your point and you keep rolling."
    put "On subsequent rolls if you:" 
    put "get your point again, you win"
    put "roll a 7, you lose"
    put "Keep rolling until you get your point or a 7."
    put "\nPress any key to continue..."..
    get input
    cls   
    % get the first round
    randint (num1,1,6)
    randint (num2,1,6)
    put "Die 1: ", num1
    delay (100)
    put "Die 2: ", num2
    sum1:= num1 + num2
    put "sum: ",sum1
    % check status
    case sum1 of
      label 7, 11: 
	status:= WIN
	put "You roll a sum of ",sum1," in your first roll. You win!!"
	put "Press any key to continue..."..
	get input
      label 2, 3, 12: 
	status:= LOSE
	put "You roll a sum of ",sum1," in your first roll. You lose!!"
	put "Press any key to continue..."..
	get input
      label: 
	% get into second round
	put "Your point from your first roll is ", sum1
	put "Since you just rolled a(n) ",sum1," you can roll again to try to get another ",sum1," to win"
	put "Press 'c' to continue, any other key to exit the game..."..
	get input
	if (input = "c") then
	  loop
	    % get numbers again
	    randint (num1,1,6)
	    randint (num2,1,6)
	    put "\n"
	    put "Die 1: ",num1
	    delay (100)
	    put "Die 2: ",num2
	    sum2:= num1 + num2
	    put "Sum: ",sum2
	    % check status
	    if (sum2 = sum1) then
	      status:= WIN
	      put "You just rolled a ",sum2," (the point). You win!!"
	      put "Press any key to continue..."..
	      get input
	    elsif (sum2 = 7) then
	      status:= LOSE
	      put "You just rolled a 7. You lose!!"
	      put "Press any key to continue..."..
	      get input
	    else 
	      status:= UK
	      put "Your point from your first roll is ",sum1
	      put "Since you just rolled a(n) ",sum1," you can roll again to try to get another ",sum1," to win"
	      put "Press 'c' to continue, any other key to exit the game..."..
	      get input
	    end if
	    exit when (sum2 = sum1 or sum2 = 7 or input not= "c")
	  end loop
	end if
    end case
    exit when (input not="c" or status not= UK)
  end loop
  % end of the game
  cls
  put "Your game has ended."..
  if (status = WIN) then
  put "You WON"
  elsif (status = LOSE) then
  put "You LOST"
  elsif (status = UK) then
  put " "
  end if
  put "Press 'c' to start a new game, any other key to exit..."..
  get input
  exit when (input not= "c")
end loop
