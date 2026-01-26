*** Settings ***
Library    Browser

*** Test Cases ***
Hello World Test
    Log    Hello, Robot Framework!

Open Example Page
    New Browser    chromium
    New Page    https://example.com
    Get Title    ==    Example Domain
    Close Browser
