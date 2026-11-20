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
    TRY
        Wait For Elements State    [data-cy="create-build"]    visible    timeout=10s
        Log    Found create-build button, clicking it    INFO
        Click    [data-cy="create-build"]
        Wait For Elements State    input[name="Anna nimi tulostelistalle"]    visible    timeout=10s
        Log    Found input field, entering list name: ${list_file}    INFO
        Fill Text    input[name="Anna nimi tulostelistalle"]    ${list_file}
        Wait For Elements State    [data-cy="prompt-ok"]    visible    timeout=10s
        Log    Found OK button, clicking it    INFO
        Click    [data-cy="prompt-ok"]
    EXCEPT
        Take Screenshot
        Fail    Failed to create list: ${CURDIR}
    END

Delete List
    ${list_file}=    Get List Filename
    TRY
        Wait For Elements State    [data-cy="list"]    visible    timeout=10s
        Log    Found list button, clicking it    INFO
        Click    [data-cy="list"]
        Wait For Elements State    [data-cy="${list_file}-remove"]    visible    timeout=10s
        Log    Found remove button for ${list_file}, clicking it    INFO
        Click    [data-cy="${list_file}-remove"]
        Wait For Elements State    [data-cy="confirm-ok"]    visible    timeout=10s
        Log    Found confirm button, clicking it    INFO
        Click    [data-cy="confirm-ok"]
    EXCEPT
        Take Screenshot
        Fail    Failed to delete list: ${list_file}
    END

Login To HSL Map Publisher Local
    New Page    ${HSL_MAP_PUBLISHER_LOCAL_URL}
    Set Suite Variable    ${HSL_MAP_PUBLISHER_LOGIN_URL}    ${HSL_MAP_PUBLISHER_LOCAL_URL}
    Click    text=Kirjaudu (HSL ID)
    Wait For Elements State    id=input-vaadin-text-field-27    visible    timeout=30s
    Get Title    ==    HSL ID UAT
    Fill Text    id=input-vaadin-text-field-27    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=input-vaadin-password-field-28    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_LOCAL_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Login To HSL Map Publisher Dev
    New Page    ${HSL_MAP_PUBLISHER_DEV_URL}
    Set Suite Variable    ${HSL_MAP_PUBLISHER_LOGIN_URL}    ${HSL_MAP_PUBLISHER_DEV_URL}
    Click    text=Kirjaudu (HSL ID)
    Wait For Elements State    id=input-vaadin-text-field-27    visible    timeout=30s
    Get Title    ==    HSL ID UAT
    Fill Text    id=input-vaadin-text-field-27    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=input-vaadin-password-field-28    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_DEV_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Login To HSL Map Publisher Prod
    New Page    ${HSL_MAP_PUBLISHER_PROD_URL}
    Set Suite Variable    ${HSL_MAP_PUBLISHER_LOGIN_URL}    ${HSL_MAP_PUBLISHER_PROD_URL}
    Click    text=Kirjaudu (HSL ID)
    Wait For Elements State    id=gwt-uid-5    visible    timeout=30s
    Get Title    ==    Sign in to HSL Kartta (juliste- ja karttageneraattori) - HSL
    Fill Text    id=gwt-uid-5    ${HSL_MAP_PUBLISHER_USER}
    Fill Text    id=gwt-uid-9    ${HSL_MAP_PUBLISHER_PASSWORD}
    Click    text=Sign in
    Wait For Navigation    ${HSL_MAP_PUBLISHER_PROD_URL}    10s
    Get Title    ==    HSL Karttajulkaisin

Logout From HSL Map Publisher
    Wait For Elements State    text=Kirjaudu ulos    visible    timeout=10s
    TRY
        Click    text=Kirjaudu ulos
    EXCEPT
        Log    Failed to click logout button, checking if navigation occurred    WARN
    END
    Wait For Navigation    ${HSL_MAP_PUBLISHER_LOGIN_URL}    10s

Logout On Teardown
    Run Keyword And Ignore Error    Logout From HSL Map Publisher

Create List And Generate Material
    [Arguments]    ${location}=1010107    ${type}=Reference    ${template}=Default
    Create List
    Generate And Download Material    location=${location}    type=${type}    template=${template}
    [Teardown]    Delete List

Generate And Download Material
    [Arguments]    ${location}=1010107    ${type}=Reference    ${template}=Default
    ${list_file}=    Get List Filename
    TRY
        Log    Opening template selector
        Wait For Elements State    [data-cy="template"]    visible    timeout=10s
        Click    [data-cy="template"]

        Log    Waiting for template options to render
        Wait For Elements State    [data-cy="select-template-with-controls"]    visible    timeout=240s
        Click    [data-cy="select-template-with-controls"]

        Log    Selecting template: ${template}
        Wait For Elements State    [data-cy="${template}"]    visible    timeout=10s
        Click    [data-cy="${template}"]

        Log    Clicking instructions section
        Wait For Elements State    h4:has-text("Ohjeet")    visible    timeout=10s
        Click    h4:has-text("Ohjeet")

        Log    Clicking generate button
        Wait For Elements State    [data-cy="generate"]    visible    timeout=10s
        Click    [data-cy="generate"]

        Log    Selecting build
        Wait For Elements State    [data-cy="build-select"]    visible    timeout=10s
        Click    [data-cy="build-select"]

        Log    Selecting list: ${list_file}
        Wait For Elements State    [data-cy="${list_file}-select"]    visible    timeout=10s
        Click    [data-cy="${list_file}-select"]

        Log    Selecting location: ${location}
        Wait For Elements State    [data-cy="${location}"]    visible    timeout=10s
        Click    [data-cy="${location}"]

        Log    Clicking final generate button
        Wait For Elements State    [data-cy="generate-button"]    visible    timeout=10s
        Click    [data-cy="generate-button"]

        Log    Switching to list view
        Wait For Elements State    [data-cy="list"]    visible    timeout=10s
        Click    [data-cy="list"]

        Log    Waiting for material generation to complete
        Wait For Elements State    [data-cy="${list_file}"] >> xpath=ancestor::div[1]/following-sibling::div >> text=/1 \/ 1 sivua generoitu|epäonnistunut/    visible    timeout=5min
        ${status_text}=    Get Text    [data-cy="${list_file}"] >> xpath=ancestor::div[1]/following-sibling::div >> text=/1 \/ 1 sivua generoitu|epäonnistunut/
        
        IF    'epäonnistunut' in '''${status_text}'''
            Handle Generation Failure    ${list_file}
            Fail    Generation failed: ${status_text}
        END
    EXCEPT
        Take Screenshot
        Fail    Failed to generate material for ${template}: ${list_file}
    END
    ${download_promise}=    Promise To Wait For Download
    Click    [data-cy="${list_file}-show"] >> xpath=following-sibling::div >> button
    ${download}=    Wait For    ${download_promise}
    Move File    ${download}[saveAs]    results/${location}-${type}.pdf

Handle Generation Failure
    [Arguments]    ${list_file}
    Click    [data-cy="${list_file}-show"]
    Take Screenshot
    Click    [data-cy="build-details-close-button"]
    



