#!/bin/bash


# Handle error(s) if there is/are any
check_exit_status(){
    error=$?
    if [[ $error -ne 0 ]]
    then
        echo -e "\033[31mFailed to create $each_project. Error received: $error\033[0m"
        echo "Failed to create $each_project. Error received: $error" > ./webstarter-error-file.log
    fi
}

# Web starter function
start_web(){

    # Create starter files for each directory
    for each_project in "${@:2}"
    do
        mkdir "$each_project" # Make as many directories as per arguments
        cd "$each_project" || exit 1 # Enter each directory created or exit program if there's an error
        check_exit_status

        # Creating HTML, CSS and JS directories and files
        touch index.html
        mkdir styles && touch styles/main.css
        mkdir js && touch js/script.js

        # HTML boilerplate code
        echo -e  "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <link rel=\"stylesheet\" href=\"styles/main.css\">\n    <script src=\"js./script.js\" defer></script>\n    <title>$each_project</title>\n</head>\n<body>\n
</body>\n</html>" > index.html

        # CSS boilerplate code
        echo -e ":root {\n    --primaryColor: #ffffff;\n    --secondaryColor: #ffffff;\n    --accentColor: #ffffff;\n    --neutralColor: #ffffff;\n    --font: sans-serif;\n}

html {\n    box-sizing: border-box;\n}

*,\n*::after,\n*::before {\n    box-sizing: inherit;\n}

body {\n    margin: 0;\n    padding: 0;\n    font-family: var(--font);\n}

h1,\nh2,\nh3,\nh4,\nh5,\nh6,\np {\n    margin: 0;\n}" > styles/main.css

        cd .. # Go back to parent folder
    done
    echo -e "\033[32mYou created $(($# -1)) web project(s)\033[0m"
}


# Shell script starter function
start_shell(){

    # Create starter file for each directory
    for each_project in "${@:2}"
    do
        mkdir "$each_project" # Make as many directories as per arguments
        cd "$each_project" || exit 1 # Enter each directory created or exit program if there's an error
        check_exit_status

        # Creating Shell file
        touch "$each_project".sh

        # Shell script boilerplate code
        echo -e  "#!/bin/bash\n" > "$each_project".sh

        cd .. # Go back to parent folder
    done
    echo -e "\033[32mYou created $(($# -1)) script file(s)\033[0m"
}


# Running program based on what flag is passed
if [[ $1 == "-w" || $1 == "--web" ]]
then
    start_web "$@"
elif [[ $1 == "-s" || $1 == "--shell" ]]
then
    start_shell "$@"
elif [[ ! $1 =~ [-] ]]
then
    echo -e "\033[31mError: Command must use a flag and an argument.\033[0m"
else
    echo -e "\033[31mError: Invalid flag, use -w for web files && -s for shell files.\033[0m"
fi