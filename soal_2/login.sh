#!/bin/bash

db_directory="data"
db_path="$db_directory/player_data.csv"

salt="IT-20-rawrrrr!"

player.login (){

if [ ! -f "$db_path" ]; then
    echo "No users have registered yet."
    sleep 1
fi


hashing() {
    echo -n "$1$salt" | sha256sum | awk '{print $1}'
}

attempt=0
max_attempts=3

echo "Enter your email:"
read email

user_found=$(grep "$email" "$db_path")

if [ -z "$user_found" ]; then
    echo "Email not registered. Please register first."
    sleep 1
	./terminal.sh
fi

while [ "$attempt" -lt "$max_attempts" ]; do

echo "Enter your password:"
read -s password

hashed_password=$(hashing "$password")

if echo "$user_found" | grep -q "$hashed_password"; then
    echo "Login successful!"
    sleep 1
    exec ./script/manager.sh
else
    echo "Invalid password. Please try again."
    sleep 0
	((attempt++))
fi

if [[ $attempt -eq $max_attempts ]]; then
            echo "Too many failed attempts. Exiting..."
            exit 1

fi
done
}

player.login
