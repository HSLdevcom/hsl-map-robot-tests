*** Settings ***
Library    Browser
Library    DocTest.PdfTest
Resource    ../../resources/hsl_map_publisher.resource

*** Variables ***
${location}    1010107

*** Test Cases ***
Compare Prod and Dev Material
    [Tags]    ci
    Login To HSL Map Publisher Prod
    Create List
    Generate And Download Material    location=${location}    type=Reference
    Delete List
    Logout From HSL Map Publisher
    
    Login To HSL Map Publisher Dev
    Create List
    Generate And Download Material    location=${location}    type=Candidate
    Delete List
    Logout From HSL Map Publisher

    ${file1}=    Set Variable    results/${location}-Reference.pdf
    ${file2}=    Set Variable    results/${location}-Candidate.pdf
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=structure
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=images
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=fonts
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=signatures

Compare Dev and Local Material
    [Tags]    local
    Login To HSL Map Publisher Dev
    Create List
    Generate And Download Material    location=${location}    type=Reference
    Delete List
    Logout From HSL Map Publisher
    
    Login To HSL Map Publisher Local
    Create List
    Generate And Download Material    location=${location}    type=Candidate
    Delete List
    Logout From HSL Map Publisher

    ${file1}=    Set Variable    results/${location}-Reference.pdf
    ${file2}=    Set Variable    results/${location}-Candidate.pdf
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=structure
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=images
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=fonts
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=signatures

Compare Prod and Local Material
    [Tags]    ci
    Login To HSL Map Publisher Prod
    Create List
    Generate And Download Material    location=${location}    type=Reference
    Delete List
    Logout From HSL Map Publisher
    
    Login To HSL Map Publisher Local
    Create List
    Generate And Download Material    location=${location}    type=Candidate
    Delete List
    Logout From HSL Map Publisher

    ${file1}=    Set Variable    results/${location}-Reference.pdf
    ${file2}=    Set Variable    results/${location}-Candidate.pdf
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=structure
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=images
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=fonts
    Run Keyword And Continue On Failure    Compare Pdf Documents    ${file1}    ${file2}    compare=signatures

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