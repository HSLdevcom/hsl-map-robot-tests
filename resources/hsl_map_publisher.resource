*** Settings ***
Library    Browser
Library    DateTime
Variables  variables.py

*** Keywords ***
Get List Filename
    ${date}=    Get Current Date    result_format=%Y-%m-%d
    ${filename}=    Set Variable    testautomation-${date}
    RETURN    ${filename}

Create List
    ${list_file}=    Get List Filename
    Click    [data-cy="create-build"]
    Fill Text    input[name="Anna nimi tulostelistalle"]    ${list_file}
    Click    [data-cy="prompt-ok"]

Delete List
    ${list_file}=    Get List Filename
    Click    [data-cy="list"]
    Click    [data-cy="${list_file}-remove"]
    Click    [data-cy="confirm-ok"]
    
Login To HSL Map Publisher
    New Browser    chromium    headless=${HEADLESS}
    New Page    ${HSL_MAP_PUBLISHER_URL}
    Click    text=Kirjaudu (HSL ID)
    Get Title    ==    Sign in to Karttatuotanto - HSL ID UAT
    Fill Text    id=gwt-uid-5    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=gwt-uid-9    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

