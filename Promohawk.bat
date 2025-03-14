@echo off
color A

:: Verificando se o Node.js está instalado
node -v >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Node.js não está instalado! baixe no site oficial
    ::pause
    exit /b
)

:: Verificando se npm está instalado
npm -v >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo npm não está instalado! Normalmente é instalado junto com o Nodejs
    ::pause
    exit /b
)

:: Verificando se git está 
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo git não está instalado! baixe no site oficial
    ::pause
    exit /b
)

::=====================================================================================================

:: colocando o nome e email no arquivo de configuração do git
set GIT_NAME=name
set GIT_EMAIL=email@teste.com

echo Configurando Git...
git config --global user.name "%GIT_NAME%"
git config --global user.email "%GIT_EMAIL%"

::=====================================================================================================

::Perguntando se deseja clonar um repositorio do GITHUB
set /p CLONE_REPO="Deseja clonar um repositório? (s/n): "
    if /i "%CLONE_REPO%" == n (
        echo Configuração concluida sem clonagem de repositorio.
        exit /b
    )
    else (
        :: Pergunta ao usuário onde deseja instalar o projeto
        set /p DRIVE="Digite a letra do disco onde deseja instalar (ex: D, E, F): "
        set /p FOLDER="Digite o nome da pasta do projeto: "
        set PROJECT_DIR=%DRIVE%:\%FOLDER%

        ::Solicitando a URL do repositorio
        ::set /p DOWNLOAD_DIR="Digite o caminho onde deseja baixar o projeto (ex: C:\Projetos): "

        :: Pergunta ao usuário o diretório onde o repositório será clonado
        set /p GIT_REPO="Digite o diretório onde o repositório será clonado: "

        :: Clona o repositório no diretório escolhido
        echo Clonando repositório...
        git clone "%GIT_REPO%" "%PROJECT_DIR%"

        :: Verifica se o repositório foi clonado com sucesso
        if exist "%PROJECT_DIR%" (
            echo Repositório clonado com sucesso!

            :: Instala dependências do Nuxt
            cd /d "%PROJECT_DIR%"
            echo Instalando dependências...
            npm install
        ) 
        else (
            echo Falha ao clonar o repositório. Verifique a URL e tente novamente.
            exit /b
        )
        pause
    )

::================================================================================================

::Instalação das dependencias do projeto
set /p DEPENDENCIA_REPO="Deseja instalar as depencias do projeto? (s/n): "
    if /i "%CLONE_REPO%" == n (
        echo Configuração concluida sem instalação de dependencias.
        exit /b
    )
    else (
        :: Pergunta ao usuário onde deseja instalar as depencias
        set /p DRIVE="Digite a letra do disco onde está o projeto (ex: D, E, F): "
        set /p FOLDER="Digite o nome da pasta do projeto: "
        set PROJECT_DIR=%DRIVE%:\%FOLDER%

       :: Instala dependências do Nuxt
        cd /d "%PROJECT_DIR%"
        echo Instalando dependências...
        npm install
    )

echo Ambiente configurado com sucesso!
pause