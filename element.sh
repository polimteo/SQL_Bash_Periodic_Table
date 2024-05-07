#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#read USER_INPUT
#check element
if [[ $1 ]]

then

  if [[ ! $1 =~ ^[0-9]+$ ]]
      #if not number
      then
      ELEMENT=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.name = '$1' OR elements.symbol = '$1'")
      
      #else read number
      else
      ELEMENT=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.atomic_number = '$1'")
    
  fi

    if [[ -z $ELEMENT ]]

      then
      echo -e "I could not find that element in the database."

      else
      echo "$ELEMENT" | while IFS="|" read ATOMIC_NUM ATOMIC_MASS MPC BPC SYM NAME TYPE

        do
          echo "The element with atomic number $ATOMIC_NUM is "$NAME" ("$SYM"). It's a "$TYPE", with a mass of $ATOMIC_MASS amu. "$NAME" has a melting point of $MPC celsius and a boiling point of $BPC celsius."
        done
    fi

else
echo "Please provide an element as an argument."

fi

