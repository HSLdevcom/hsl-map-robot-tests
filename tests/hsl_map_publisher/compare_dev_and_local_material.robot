*** Settings ***
Library    Browser
Library    DocTest.PdfTest
Resource    ../../resources/hsl_map_publisher.resource

*** Variables ***
${location}    1010107

*** Test Cases ***
Compare Dev and Local Material
    [Tags]    local
    [Teardown]    Run Keyword And Ignore Error    Logout From HSL Map Publisher
    Login To HSL Map Publisher Dev
    Create List And Generate Material    location=${location}    type=Reference
    Logout From HSL Map Publisher
    
    Login To HSL Map Publisher Local
    Create List And Generate Material    location=${location}    type=Candidate
    Logout From HSL Map Publisher

    ${file1}=    Set Variable    results/${location}-Reference.pdf
    ${file2}=    Set Variable    results/${location}-Candidate.pdf
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=structure
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=images
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=fonts
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=signatures

Generate Local Material
    [Tags]    local
    [Teardown]    Run Keyword And Ignore Error    Logout From HSL Map Publisher
    Login To HSL Map Publisher Local
    Create List And Generate Material    location=${location}    type=Local
    Logout From HSL Map Publisher

Generate Dev Material
    [Tags]    local
    [Teardown]    Run Keyword And Ignore Error    Logout From HSL Map Publisher
    Login To HSL Map Publisher Dev
    Create List And Generate Material    location=${location}    type=Local
    Logout From HSL Map Publisher

Just Compare Files
    [Tags]    local
    ${file1}=    Set Variable    results/${location}-Reference.pdf
    ${file2}=    Set Variable    results/${location}-Candidate.pdf
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=structure
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=images
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=fonts
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=signatures
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=metadata
