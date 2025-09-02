*** Settings ***
| Library | SeleniumLibrary
| Resource | tests/keywords/miscKeywords.robot

*** Variables ***
| ${ROOT} | http://${HOST}:${PORT}

*** Keywords ***
| Setup Test With Root
| | [Arguments] | @{args}
| | start rfhub | --port | ${PORT} | @{args}
| | open browser | ${ROOT} | ${BROWSER}

| Teardown Test
| | stop rfhub
| | close all browsers

*** Test Cases ***
| Specify --root /doc
| | [Documentation]
| | ... | Verify that --root /doc works properly
| | [Setup] | Setup Test With Root | --root | /doc
| | [Teardown] | Teardown Test
| | go to | ${ROOT}/
| | location should be | ${ROOT}/doc/

| Use default root (no --root option)
| | [Documentation]
| | ... | Verify that when --root is not supplied, we go to dashboard
| | [Setup] | Setup Test With Root
| | [Teardown] | Teardown Test
| | go to | ${ROOT}/
| | location should be | ${ROOT}/doc/
