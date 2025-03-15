#!/bin/bash

db_directory="data"
db_path="data/player_data.csv"

salt="IT-20-rawrrrr!"

if [ ! -d "$db_directory" ]; then
    echo "Directory $DB_DIR does not exist. Creating..."
    mkdir -p "$db_directory"
    echo "Directory $DB_DIR created."
fi

if [ ! -f "$db_path" ]; then
    echo "email,username,password" > "$db_path"
fi

register.player(){

validate_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

validate_password() {
    if [[ ${#1} -lt 8 ]]; then
        echo "Password must be at least 8 characters long."
        return 1
    elif ! [[ "$1" =~ [A-Z] ]]; then
        echo "Password must contain at least one uppercase letter."
       return 1
    elif ! [[ "$1" =~ [0-9] ]]; then
        echo "Password must contain at least one number."
        return 1
    else
        return 0
    fi
}

hashing(){
echo -n "$1$salt" | sha256sum | awk '{print $1}'

}

generate_id (){
max_id=$(tail -n +2 "$db_path" | cut -d ',' -f1 | sort -n | tail -n 1)
    if [ -z "$max_id" ]; then
    echo "1"

    else
        echo $((max_id + 1))
    fi

}

echo "Enter your email:"
read email

if ! validate_email "$email"; then
    echo "Invalid email format. Please enter a valid email address."
    return 1
fi

echo "Enter your username:"
read username

if grep -q "$email" "$db_path"; then
    echo "This email is already registered. Please log in instead."
     sleep 1
	./terminal.sh
fi

while true; do
    echo "Enter your password:"
    read -s password
    if ! validate_password "$password"; then
        echo "Please try again."
    else
        break
    fi
done

hashed_password=$(hashing "$password")

player_id=$(generate_id)

if grep -q "$email" "$db_path"; then
    echo "Email already registered. Please use a different email."
    exit 1
fi

echo "$player_id,$email,$username,$hashed_password" >> "$db_path"
echo "Registration successful! Im waiting for you to come soldier!"
}

register.player
