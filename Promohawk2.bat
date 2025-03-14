@echo off
setlocal enabledelayedexpansion

:: Exibe um banner estilizado
echo.
echo.
echo #######################################################################################################
echo #  $$$$$$$\                                              $$\                               $$\        #
echo #  $$  __$$\                                             $$ |                              $$ |       #
echo #  $$ |  $$ | $$$$$$\   $$$$$$\  $$$$$$\$$$$\   $$$$$$\  $$$$$$$\   $$$$$$\  $$\  $$\  $$\ $$ |  $$\  #
echo #  $$$$$$$  |$$  __$$\ $$  __$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\  \____$$\ $$ | $$ | $$ |$$ | $$  | #
echo #  $$  ____/ $$ |  \__|$$ /  $$ |$$ / $$ / $$ |$$ /  $$ |$$ |  $$ | $$$$$$$ |$$ | $$ | $$ |$$$$$$  /  #
echo #  $$ |      $$ |      $$ |  $$ |$$ | $$ | $$ |$$ |  $$ |$$ |  $$ |$$  __$$ |$$ | $$ | $$ |$$  _$$<   #
echo #  $$ |      $$ |      \$$$$$$  |$$ | $$ | $$ |\$$$$$$  |$$ |  $$ |\$$$$$$$ |\$$$$$\$$$$  |$$ | \$$\  #
echo #  \__|      \__|       \______/ \__| \__| \__| \______/ \__|  \__| \_______| \_____\____/ \__|  \__| #
echo #######################################################################################################                                                                                                 
echo.                                                                                                  
echo.

:: Defina o nome e email do Git diretamente no script
set GIT_NAME=SeuNome
set GIT_EMAIL=seuemail@example.com

echo Configurando Git...
git config --global user.name "%GIT_NAME%"
git config --global user.email "%GIT_EMAIL%"

:: Verifica se o Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Instalando o Node.js...
    powershell -Command "& {Invoke-WebRequest -Uri https://nodejs.org/dist/v18.16.1/node-v18.16.1-x64.msi -OutFile nodejs.msi}"
    msiexec /i nodejs.msi /quiet /norestart
    del nodejs.msi
)

:: Verifica se o Vue CLI está instalado
where vue >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Instalando Vue CLI...
    npm install -g @vue/cli
)

:: Pergunta ao usuário onde deseja instalar o projeto
set /p DRIVE="Digite a letra do disco onde deseja instalar (ex: D, E, F): "
set /p FOLDER="Digite o nome da pasta do projeto: "
set PROJECT_DIR=%DRIVE%:\%FOLDER%

:: Verifica se o projeto já existe
if exist "%PROJECT_DIR%" (
    echo O projeto já está instalado em %PROJECT_DIR%.
    set /p UPDATE="Deseja atualizar o repositório? (S/N): "
    if /I "%UPDATE%"=="S" (
        cd /d "%PROJECT_DIR%"
        git pull
        echo Repositório atualizado com sucesso!
    ) else (
        echo Nenhuma alteração feita.
    )
) else (
    :: Pergunta ao usuário a URL do repositório
    set /p GIT_REPO="Digite a URL do repositório GitHub: "
    
    :: Clona o repositório no diretório escolhido
    echo Clonando repositório...
    git clone "%GIT_REPO%" "%PROJECT_DIR%"
    
    if exist "%PROJECT_DIR%" (
        echo Repositório clonado com sucesso!
    ) else (
        echo Falha ao clonar o repositório. Verifique a URL e tente novamente.
        exit /b
    )
)

:: Instala dependências do Nuxt
cd /d "%PROJECT_DIR%"
echo Instalando dependências...
npm install

echo Ambiente configurado com sucesso!
pause