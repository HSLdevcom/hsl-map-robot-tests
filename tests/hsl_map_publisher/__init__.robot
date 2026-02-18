*** Settings ***
Library    Browser
Resource    ../../resources/hsl_map_publisher.resource
Suite Setup    New Browser    chromium    headless=${HEADLESS}
Suite Teardown  Close Browser

