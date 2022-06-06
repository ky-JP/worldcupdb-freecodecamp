#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
chmod +x insert_data.sh
echo $($PSQL "truncate teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" && $OPPONENT != "opponent" && $YEAR != "year" && $ROUND != "round" && $WINNER_GOALS != "winner_goals"
  && $OPPONENT_GOALS != "opponent_goals" ]]
  then
    FTEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    STEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")    

    if [[ -z $FTEAM_ID ]]
    then
      INSERT_WINNER=$($PSQL "insert into teams(name) values('$WINNER')")           
    fi  

    FTEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    if [[ -z $STEAM_ID ]]
    then
      INSERT_OPPONENT=$($PSQL "insert into teams(name) values('$OPPONENT')")       
    fi
    
    STEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")  
    
    INSERT_GAME=$($PSQL "insert into games(year, round, winner_id,
    opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND',
    $FTEAM_ID, $STEAM_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

  fi
done
