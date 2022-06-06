#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams::"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT (SUM(winner_goals) + SUM(opponent_goals)) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE WINNER_GOALS > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name from teams join games on teams.team_id=games.winner_id where games.round='Final' and games.year=2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "select name from teams join games on team_id=games.winner_id or team_id=games.opponent_id where games.round='Eighth-Final' and games.year=2014 order by name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct(teams.name) from teams join games on teams.team_id = games.winner_id order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select games.year, teams.name from teams join games on teams.team_id = games.winner_id where games.round = 'Final' order by games.year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "select teams.name from teams where name like 'Co%'")"
