*** Settings ***
Library    Browser
Library    DateTime
Library    OperatingSystem
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

Login To HSL Map Publisher Local
    New Page    ${HSL_MAP_PUBLISHER_LOCAL_URL}
    Click    text=Kirjaudu (HSL ID)
    Get Title    ==    Sign in to Karttatuotanto - HSL ID UAT
    Fill Text    id=gwt-uid-5    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=gwt-uid-9    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_LOCAL_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Login To HSL Map Publisher Dev
    New Page    ${HSL_MAP_PUBLISHER_DEV_URL}
    Click    text=Kirjaudu (HSL ID)
    Get Title    ==    Sign in to Karttatuotanto - HSL ID UAT
    Fill Text    id=gwt-uid-5    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=gwt-uid-9    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_DEV_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Login To HSL Map Publisher Prod
    New Page    ${HSL_MAP_PUBLISHER_PROD_URL}
    Click    text=Kirjaudu (HSL ID)
    Get Title    ==    Sign in to HSL Kartta (juliste- ja karttageneraattori) - HSL
    Fill Text    id=gwt-uid-5    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=gwt-uid-9    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_PROD_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Logout From HSL Map Publisher
    Click    text=Kirjaudu ulos

Generate And Download Material
    [Arguments]    ${location}= 1010107    ${type}= Reference    
    ${list_file}=    Get List Filename
    Click    [data-cy="template"]
    Click    [data-cy="select-template-with-controls"]
    Click    [data-cy="Default"]
    Click    h4:has-text("Ohjeet")
    Click    [data-cy="generate"]
    Click    [data-cy="build-select"]
    Click    [data-cy="${list_file}-select"]
    Click    [data-cy="${location}"]
    Click    [data-cy="generate-button"]
    Click    [data-cy="list"]
    Wait For Elements State    [data-cy="${list_file}"] >> xpath=ancestor::div[1]/following-sibling::div >> text=1 / 1 sivua generoitu    visible    timeout=5min
    ${download_promise}=    Promise To Wait For Download
    Click    [data-cy="${list_file}-show"] >> xpath=following-sibling::div >> button
    ${download}=    Wait For    ${download_promise}
    Move File    ${download}[saveAs]    results/${location}-${type}.pdf
