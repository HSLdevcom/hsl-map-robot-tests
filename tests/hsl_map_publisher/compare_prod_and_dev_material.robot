*** Settings ***
Library    Browser
Library    DocTest.PdfTest
Resource    ../../resources/hsl_map_publisher.resource


*** Test Cases ***
Compare Prod and Dev Material
    ${location}=    Set Variable    1010107

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
    Compare Pdf Documents    ${file1}    ${file2}    compare=text
    Compare Pdf Documents    ${file1}    ${file2}    compare=structures
    Compare Pdf Documents    ${file1}    ${file2}    compare=images
