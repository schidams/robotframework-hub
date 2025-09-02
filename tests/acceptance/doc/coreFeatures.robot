*** Settings ***
| Library  | Collections
| Library | SeleniumLibrary
| Library | Dialogs
| Resource | ${KEYWORD_DIR}/APIKeywords.robot
| Suite Setup | Run keywords
| ... | Create session | rfhub | url=http://${host}:${port} | AND
| ... | Open Browser | ${ROOT} | ${BROWSER}
| Suite Teardown  | Teardown Suite

*** Variables ***
| ${ROOT} | http://${HOST}:${PORT}

*** Keywords ***
| Teardown Suite
| | Delete All Sessions
| | Close all browsers

*** Test Cases ***
| Nav panel shows correct number of collections
| | [Documentation]
| | ... | Verify that the nav panel has the correct number of items
| |
| | [Tags] | navpanel
| | [Setup] | Run keywords
| | ... | Get list of libraries via the API | AND
| | ... | Go to | ${ROOT}/doc/
| |
| | ${actual} | Get element count | //*[@id="left"]/ul/li/label
| | Should Be Equal As Integers | ${actual} | 8
| | ... | Expected 8 items in navlist, found ${actual}

| Nav panel shows all libraries
| | [Documentation]
| | ... | Verify that the nav panel shows all of the collections
| |
| | [Tags] | navpanel
| | [Setup] | Run keywords
| | ... | Get list of collections via the API | AND
| | ... | Go to | ${ROOT}/doc/
| |
| | FOR | ${collection} | IN | @{collections}
| | | Page should contain element
| | | ... | //*[@id="left"]/ul/li/label[./text()='${collection["name"]}']
| | | ... | limit=1
| | END

| Main panel shows correct number of libraries
| | [Documentation]
| | ... | Verify that the main panel has the correct number of items
| |
| | [Tags] | navpanel
| | [Setup] | Run keywords
| | ... | Get list of libraries via the API | AND
| | ... | Go to | ${ROOT}/doc/
| |
| | ${actual} | Get element count | //*[@id="right"]/div[1]/table/tbody/tr/td/a
| | # why 5? Because we explicitly load 5 libraries in the suite setup
| | Should Be Equal As Integers | ${actual} | 5
| | ... | Expected 5 items in navlist, found ${actual}


| Main panel shows all libraries
| | [Documentation]
| | ... | Verify that the main panel shows all of the libraries
| |
| | [Setup] | Run keywords
| | ... | Get list of libraries via the API | AND
| | ... | Go to | ${ROOT}/doc
| |
| | FOR | ${lib} | IN | @{libraries}
| | | ${name} | Get from dictionary | ${lib} | name
| | | Page should contain element
| | | ... | //*[@id="right"]//a[./text()='${name}']
| | | ... | limit=1
| | END

| Main panel shows all library descriptions
| | [Documentation]
| | ... | Verify that the main panel shows all of the library descriptions
| |
| | [Setup] | Run keywords
| | ... | Get list of libraries via the API | AND
| | ... | Go to | ${ROOT}/doc
| |
| | ${section}= | Set variable |
| | FOR | ${lib} | IN | @{libraries}
| | | ${expected}= | Get from dictionary | ${lib} | synopsis
| | | ${actual}=   | Get text | //*[@id="right"]//a[text()='${lib["name"]}']/../following-sibling::td
| | | Should be equal | ${expected} | ${actual}
| | END

*** Keywords ***
| Get list of libraries via the API
| | [Documentation]
| | ... | Uses the hub API to get a list of libraries.
| | ... | The libraries are stored in a suite-level variable
| |
| | # N.B. 'Do a git on' stores the response in a test variable named ${JSON}
| | Do a get on | /api/libraries
| | ${libraries}= | Get From Dictionary | ${JSON} | libraries
| | Set suite variable | ${libraries}

| Get list of collections via the API
| | [Documentation]
| | ... | Uses the hub API to get a list of all collections (libraries + resources).
| | ... | The collections are stored in a suite-level variable
| |
| | # Get all collections from the API
| | Do a get on | /api/libraries
| | ${collections}= | Get From Dictionary | ${JSON} | libraries
| | Set suite variable | ${collections}
