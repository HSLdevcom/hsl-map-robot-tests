
*** Settings ***
Library    Browser
Variables  ../../resources/variables.py

*** Test Cases ***
Hello World Test
    Log    Hello, Robot Framework!

Open Example Page
    New Browser    chromium    headless=${HEADLESS}
    New Page    ${EXAMPLE_URL}
    Get Title    ==    Example Domain
    Close Browser
