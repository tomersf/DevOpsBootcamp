#!/bin/bash

main() {
    apt update
    apt install -y default-jre
    if java -version &>/dev/null; then
        echo "Java is installed... checking version"
        java_version_lower_than_11=$(check_is_java_version_lower_than_11)
        if [[ "$java_version_lower_than_11" -eq 0 ]]; then
            echo "Java version is lower than 11"
        else
            echo "Java version is 11 or higher"
        fi

    else
        echo "Java installation failed"
        exit 1
    fi
}

check_is_java_version_lower_than_11() {
    local java_version
    java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -c 1-2)
    if [[ "$java_version" -lt 11 ]]; then
        return 0
    elif [[ "$java_version" -ge 11 ]]; then
        return 1
    else
        echo "Unable to determine java version, exiting script"
        exit 1
    fi
}

main
