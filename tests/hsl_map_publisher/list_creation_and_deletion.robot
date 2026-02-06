*** Settings ***
Library    Browser
Resource    ../../resources/hsl_map_publisher.resource


*** Test Cases ***
List Creation And Deletion
    Create List
    Sleep    10s
    Delete List
    Sleep    2s

