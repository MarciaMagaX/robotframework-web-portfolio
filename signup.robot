*** Settings ***
Documentation        Suite de testes de Cadastro de dog walker

Library        Browser


*** Test Cases ***
Deve poder cadastrar um novo dog walker

    ${name}                    Set Variable        Marcia Silva
    ${email}                   Set Variable        marcia@gmail.com
    ${cpf}                     Set Variable        00000014141
    ${cep}                     Set Variable        01311-000
    ${addressStreet}           Set Variable        Avenida Paulista
    ${addressDistrict}         Set Variable        Bela Vista
    ${addressCityUf}           Set Variable        São Paulo/SP
    ${addressNumber}           Set Variable        300
    ${addressDetails}          Set Variable        Apto 12
    ${cnh}                     Set Variable        SAMPLE.jpg

    Go to signup page
    Fill signup forms    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}    ${cnh}
    Submit signup form
    Popup should be        Recebemos o seu cadastro e em breve retornaremos o contato. 

*** Keywords ***

Go to signup page
    New Browser    browser=chromium    headless=False
    New Page        https://walkdog.vercel.app/signup

    Wait For Elements State    form h1    visible    timeout=5000
    Get Text    form h1    equal    Faça seu cadastro

Fill signup forms
    [Arguments]    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}    ${cnh}    
    Fill Text        css=input[name="name"]                ${name}
    Fill Text        css=input[name="email"]               ${email}
    Fill Text        css=input[name="cpf"]                 ${cpf}
    Fill Text        css=input[name="cep"]                 ${cep}

    Click            css=input[value="Buscar CEP"]

    Get Property    css=input[name=addressStreet]      value        equal            ${addressStreet}
    Get Property    css=input[name=addressDistrict]    value        equal            ${addressDistrict}
    Get Property    css=input[name=addressCityUf]      value        equal            ${addressCityUf}
    


    Fill Text        css=input[name="addressNumber"]       ${addressNumber}
    Fill Text        css=input[name="addressDetails"]      ${addressDetails}

    Upload File By Selector        css=input[type=file]        ${EXECDIR}/${cnh}

Submit signup form
    Click            css=.button-register

Popup should be
    [Arguments]    ${expected_text}
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text        css=.swal2-html-container    equal    ${expected_text}
 
    


